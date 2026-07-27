import Combine
import SwiftUI

/// 管理單字清單畫面的狀態與事件。
@MainActor
final class VocabularyViewModel: ObservableObject {
    /// Vocabulary 頁面的畫面狀態。
    enum ViewState: Equatable {
        case empty
        case loading
        case finish
    }

    /// 由上層路由傳入的等級。
    let level: JLPTLevel

    /// 單字資料 Repository。
    private let vocabularyRepository: VocabularyRepository?

    /// 收藏狀態儲存器。
    private let favoritesStore: FavoritesStore?

    /// 目前收藏的 Key 集合。
    private var favoriteKeys: Set<String>

    /// Log 用途的 logger。
    /// - Note: 只用於輸出可觀測訊息，避免落入敏感資訊。
    private let logService: LogService

    /// 語音播放服務
    private let voiceService: VoiceService

    /// 搜尋文字。
    @Published
    var searchText: String

    /// 畫面使用的單字清單。
    @Published
    private(set) var vocabularyItems: [VocabularyCardView.StateItem]

    /// 依照搜尋文字篩選後的清單。
    @Published
    private(set) var filteredItems: [VocabularyCardView.StateItem] = []

    /// Vocabulary 頁面的呈現狀態。
    @Published
    private(set) var viewState: ViewState

    /// 建立單字清單 ViewModel。
    /// - Parameters:
    ///   - level: 目前選取的 JLPT 等級。
    ///   - repository: 單字資料 Repository。
    ///   - favoritesStore: 收藏狀態儲存器。
    init(
        level: JLPTLevel,
        repository: VocabularyRepository?,
        favoritesStore: FavoritesStore?,
        logService: LogService = LoggerService.shared,
        voiceService: VoiceService = JapaneseVoiceService.shared,
        vocabularyItems: [VocabularyCardView.StateItem] = []
    ) {
        self.level = level
        self.vocabularyRepository = repository
        self.favoritesStore = favoritesStore
        self.favoriteKeys = []
        self.logService = logService
        self.voiceService = voiceService
        self.searchText = ""
        self.vocabularyItems = vocabularyItems
        self.filteredItems = vocabularyItems
        self.viewState = vocabularyItems.isEmpty ? .empty : .finish
    }

    /// 載入指定等級的單字清單。
    /// - Important: 僅首次呼叫會實際載入。
    func loadVocabulary() async {
        guard vocabularyItems.isEmpty else {
            updateViewState(for: filteredItems)
            return
        }

        viewState = .loading

        defer {
            if viewState == .loading {
                updateViewState(for: filteredItems)
            }
        }

        guard let vocabularyRepository, let favoritesStore else {
            vocabularyItems = []
            filteredItems = []
            return
        }

        do {
            let vocabulary = try await vocabularyRepository.fetch(level: level)
            let favorites = favoritesStore.loadFavorites()

            favoriteKeys = favorites

            let items = vocabulary.map { item in
                let favoriteKey = FavoriteKey.make(word: item.word, furigana: item.furigana, level: level)
                return VocabularyCardView.StateItem(
                    kanji: item.word,
                    kana: item.furigana,
                    romaji: item.romaji,
                    isFavorite: favorites.contains(favoriteKey),
                    favoriteKey: favoriteKey
                )
            }

            vocabularyItems = items
            filteredItems = items
            updateViewState(for: items)
        } catch {
            logService.error("載入單字清單失敗。原因：\(error.localizedDescription)")
            vocabularyItems = []
            filteredItems = []
            updateViewState(for: [])
        }
    }

    /// 依照搜尋條件更新篩選清單（含 300ms debounce）。
    /// - Important: 提供 `.task(id:)` 使用，會在取消時停止更新。
    func updateFilteredItems() async {
        let currentQuery = searchText
        let currentItems = vocabularyItems

        guard !currentItems.isEmpty else {
            return
        }

        do {
            try await Task.sleep(for: .milliseconds(300))
        } catch {
            return
        }

        guard Task.isCancelled == false else {
            return
        }

        filteredItems = await filter(items: currentItems, query: currentQuery)
        updateViewState(for: filteredItems)
    }

    /// 切換指定單字的收藏狀態。
    /// - Parameter item: 目標單字。
    func toggleFavorite(for item: VocabularyCardView.StateItem) async {
        guard let index = vocabularyItems.firstIndex(where: { $0.favoriteKey == item.favoriteKey }) else {
            return
        }

        vocabularyItems[index].isFavorite.toggle()

        let isFavorite = vocabularyItems[index].isFavorite

        if isFavorite {
            favoriteKeys.insert(item.favoriteKey)
        } else {
            favoriteKeys.remove(item.favoriteKey)
        }

        filteredItems = await filter(items: vocabularyItems, query: searchText)
        updateViewState(for: filteredItems)
    }

    /// 保存收藏狀態
    func saveFavorite() {
        favoritesStore?.saveFavorites(favoriteKeys)
    }

    /// 播放語音
    func playVoice(for item: VocabularyCardView.StateItem) {
        voiceService.play(for: item.kana.isEmpty ? item.kanji : item.kana, rate: .normal)
    }

    /// 依照搜尋條件回傳篩選結果。
    /// - Parameters:
    ///   - items: 目標清單。
    ///   - query: 目前搜尋文字。
    /// - Returns: 經過搜尋條件篩選後的清單。
    private func filter(items: [VocabularyCardView.StateItem], query: String) async -> [VocabularyCardView.StateItem] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.isEmpty == false else {
            return items
        }

        return items.filter { item in
            item.kanji.localizedCaseInsensitiveContains(trimmed)
                || item.kana.localizedCaseInsensitiveContains(trimmed)
                || item.romaji.localizedCaseInsensitiveContains(trimmed)
        }
    }

    /// 依照目前列表內容更新畫面狀態。
    /// - Parameter items: 目前應顯示的資料列表。
    private func updateViewState(for items: [VocabularyCardView.StateItem]) {
        viewState = items.isEmpty ? .empty : .finish
    }
}
