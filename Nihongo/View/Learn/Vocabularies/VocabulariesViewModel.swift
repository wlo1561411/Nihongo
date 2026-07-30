import Combine
import Foundation

/// 管理單字清單畫面的狀態與事件。
@MainActor
final class VocabulariesViewModel: ObservableObject {
    /// Vocabulary 頁面的畫面狀態。
    enum ViewState: Equatable {
        case empty
        case loading
        case finish
    }

    /// 由上層路由傳入的等級。
    let level: JLPTLevel

    /// 單字資料 store。
    private let vocabularyStore: VocabularyStore?

    /// 收藏狀態 store。
    private let favoritesStore: FavoritesStore?

    /// 語音播放服務
    private let voiceService: VoiceService

    /// Log 用途的 logger。
    private let logService: LogService

    /// 搜尋文字。
    @Published
    var searchText: String

    /// 全部的單字原始資料。
    private(set) var vocabularies: [any Vocabulary]

    /// 全部的單字清單。
    private(set) var vocabularyCardStates: [VocabularyCardsView.CardState]

    /// 當前畫面上的清單。
    @Published
    private(set) var currentCardStates: [VocabularyCardsView.CardState] {
        didSet {
            viewState = currentCardStates.isEmpty ? .empty : .finish
        }
    }

    /// Vocabulary 頁面的呈現狀態。
    @Published
    private(set) var viewState: ViewState

    /// 建立單字清單 ViewModel。
    init(
        level: JLPTLevel,
        vocabularyStore: VocabularyStore? = JLPTLocalVocabularyStore.shared,
        favoritesStore: FavoritesStore? = UserDefaultsFavoritesStore.shared,
        logService: LogService = LoggerService.shared,
        voiceService: VoiceService = JapaneseVoiceService.shared,
        searchText: String = "",
        vocabularies: [any Vocabulary] = [],
        vocabularyCardStates: [VocabularyCardsView.CardState] = []
    ) {
        self.level = level
        self.vocabularyStore = vocabularyStore
        self.favoritesStore = favoritesStore
        self.logService = logService
        self.voiceService = voiceService
        self.searchText = searchText
        self.vocabularies = vocabularies
        self.vocabularyCardStates = vocabularyCardStates
        self.currentCardStates = vocabularyCardStates
        self.viewState = vocabularyCardStates.isEmpty ? .empty : .finish
    }

    /// 載入指定等級的單字清單。
    /// - Important: 僅首次呼叫會實際載入。
    func load() async {
        guard vocabularyCardStates.isEmpty else {
            await refreshFavorites()
            return
        }

        viewState = .loading

        do {
            let vocabularies = try await vocabularyStore?.fetch(level: level) ?? []
            self.vocabularies = vocabularies

            let favorites = await favoritesStore?.loadFavorites() ?? []

            vocabularyCardStates = vocabularies
                .map {
                    .init(vocabulary: $0, favorites: favorites)
                }

            applyCurrentSearchAndSort()
        } catch {
            logService.error("載入單字清單失敗。原因：\(error.localizedDescription)")

            vocabularies = []
            vocabularyCardStates = []
            currentCardStates = []
        }
    }

    /// 從收藏儲存器重新套用收藏狀態，並以完整單字清單重新推導目前列表。
    func refreshFavorites() async {
        guard vocabularyCardStates.isEmpty == false else {
            return
        }

        let favorites = await favoritesStore?.loadFavorites() ?? []

        vocabularyCardStates = vocabularyCardStates.map { item in
            var item = item
            item.isFavorite = favorites.contains(item.id)
            return item
        }

        logService.debug("已同步單字清單收藏狀態。數量：\(favorites.count)")

        applyCurrentSearchAndSort()
    }

    /// 使用目前完整清單與搜尋文字重新推導顯示清單。
    private func applyCurrentSearchAndSort() {
        let filtered = filter(items: vocabularyCardStates, searchText: searchText)
        currentCardStates = sortByFavorite(filtered)
    }
}

// MARK: - Action

extension VocabulariesViewModel {
    /// 依照搜尋條件更新篩選清單（含 300ms debounce）。
    /// - Important: 提供 `.task(id:)` 使用，會在取消時停止更新。
    func searching() async {
        do {
            try await Task.sleep(for: .milliseconds(300))
        } catch {
            return
        }

        guard Task.isCancelled == false else {
            return
        }

        guard vocabularyCardStates.isEmpty == false else {
            return
        }

        applyCurrentSearchAndSort()
    }

    /// 切換指定單字的收藏狀態。
    func toggleFavorite(for item: VocabularyCardsView.CardState) async {
        guard let index = vocabularyCardStates.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        vocabularyCardStates[index].isFavorite.toggle()

        await favoritesStore?
            .execute(
                key: item.id,
                isFavorite: vocabularyCardStates[index].isFavorite
            )

        applyCurrentSearchAndSort()
    }

    /// 播放語音
    func playVoice(for item: VocabularyCardsView.CardState) {
        voiceService.play(for: item.furigana.isEmpty ? item.word : item.furigana, mode: .word)
    }
}

// MARK: - Data

extension VocabulariesViewModel {
    /// 依照搜尋條件回傳篩選結果。
    private func filter(
        items: [VocabularyCardsView.CardState],
        searchText: String
    ) -> [VocabularyCardsView.CardState] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.isEmpty == false else {
            return items
        }

        return items.filter { item in
            item.word.localizedCaseInsensitiveContains(trimmed)
                || item.furigana.localizedCaseInsensitiveContains(trimmed)
                || item.romaji.localizedCaseInsensitiveContains(trimmed)
        }
    }

    /// 將收藏項目排在前面，並保留同群組內的原始順序。
    private func sortByFavorite(_ items: [VocabularyCardsView.CardState]) -> [VocabularyCardsView.CardState] {
        var favoriteItems: [VocabularyCardsView.CardState] = []
        var otherItems: [VocabularyCardsView.CardState] = []

        favoriteItems.reserveCapacity(items.count)
        otherItems.reserveCapacity(items.count)

        for item in items {
            if item.isFavorite {
                favoriteItems.append(item)
            } else {
                otherItems.append(item)
            }
        }

        return favoriteItems + otherItems
    }

    func makeDetailViewModel(for item: VocabularyCardsView.CardState) -> VocabularyDetailViewModel? {
        guard let vocabulary = vocabularies.first(where: { $0.word == item.word }) else {
            return nil
        }

        return .init(
            word: vocabulary.word,
            furigana: vocabulary.furigana,
            romaji: vocabulary.romaji,
            meaning: vocabulary.meaning(by: .zh),
            example: vocabulary.example(by: .ja),
            translatedExample: vocabulary.example(by: .zh),
            partOfSpeech: vocabulary.partOfSpeech,
            isFavorite: item.isFavorite,
            upcomingVocabularies: vocabularies
        )
    }
}
