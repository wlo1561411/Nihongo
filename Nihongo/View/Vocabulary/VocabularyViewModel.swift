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

    /// 單字資料 store。
    private let vocabularyStore: VocabularyStore?

    /// 收藏狀態 store。
    private let favoritesStore: FavoritesStore?

    /// 目前收藏的 Key 集合。
    private var favoriteKeys: Set<String>

    /// Log 用途的 logger。
    /// - Note: 只用於輸出可觀測訊息，避免落入敏感資訊。
    private let logService: LogService

    /// 語音播放服務
    private let voiceService: VoiceService

    /// 資料轉換與排序邏輯
    private let processor = Processor()

    /// 搜尋文字。
    @Published
    var searchText: String

    /// 全部的單字清單。
    private(set) var vocabularyItems: [VocabularyCardView.StateItem]

    /// 依照搜尋文字篩選後的清單。
    @Published
    private(set) var currentItems: [VocabularyCardView.StateItem] = [] {
        didSet {
            viewState = currentItems.isEmpty ? .empty : .finish
        }
    }

    /// Vocabulary 頁面的呈現狀態。
    @Published
    private(set) var viewState: ViewState

    /// 建立單字清單 ViewModel。
    /// - Parameters:
    ///   - level: 目前選取的 JLPT 等級。
    ///   - store: 單字資料 Store。
    ///   - favoritesStore: 收藏狀態儲存器。
    init(
        level: JLPTLevel,
        store: VocabularyStore?,
        favoritesStore: FavoritesStore?,
        logService: LogService = LoggerService.shared,
        voiceService: VoiceService = JapaneseVoiceService.shared,
        vocabularyItems: [VocabularyCardView.StateItem] = []
    ) {
        self.level = level
        self.vocabularyStore = store
        self.favoritesStore = favoritesStore
        self.favoriteKeys = []
        self.logService = logService
        self.voiceService = voiceService
        self.searchText = ""
        self.vocabularyItems = vocabularyItems
        self.currentItems = vocabularyItems
        self.viewState = vocabularyItems.isEmpty ? .empty : .finish
    }

    /// 載入指定等級的單字清單。
    /// - Important: 僅首次呼叫會實際載入。
    func loadVocabulary() async {
        guard vocabularyItems.isEmpty else {
            currentItems = []
            return
        }

        viewState = .loading

        guard let vocabularyStore, let favoritesStore else {
            vocabularyItems = []
            currentItems = []
            return
        }

        do {
            let vocabulary = try await vocabularyStore.fetch(level: level)
            let favorites = favoritesStore.loadFavorites()
            let items = processor.makeItems(vocabulary: vocabulary, level: level, favorites: favorites)

            favoriteKeys = favorites
            vocabularyItems = items

            let sorted = await processor.filteredAndSortedItems(from: items, query: "")
            currentItems = sorted
        } catch {
            logService.error("載入單字清單失敗。原因：\(error.localizedDescription)")
            vocabularyItems = []
            currentItems = []
        }
    }

    /// 依照搜尋條件更新篩選清單（含 300ms debounce）。
    /// - Important: 提供 `.task(id:)` 使用，會在取消時停止更新。
    func updateFilteredItems() async {
        let searchText = searchText
        let vocabularyItems = vocabularyItems

        guard !vocabularyItems.isEmpty else {
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

        let items = await processor.filteredAndSortedItems(from: vocabularyItems, query: searchText)

        guard Task.isCancelled == false else {
            return
        }

        currentItems = items
    }

    /// 切換指定單字的收藏狀態。
    /// - Parameter item: 目標單字。
    func toggleFavorite(for item: VocabularyCardView.StateItem) async {
        guard let index = vocabularyItems.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        vocabularyItems[index].isFavorite.toggle()

        let isFavorite = vocabularyItems[index].isFavorite

        if isFavorite {
            favoriteKeys.insert(item.id)
        } else {
            favoriteKeys.remove(item.id)
        }

        let vocabularyItems = vocabularyItems
        let searchText = searchText
        let items = await processor.filteredAndSortedItems(from: vocabularyItems, query: searchText)

        currentItems = items
    }

    /// 保存收藏狀態
    func saveFavorite() {
        favoritesStore?.saveFavorites(favoriteKeys)
    }

    /// 播放語音
    func playVoice(for item: VocabularyCardView.StateItem) {
        voiceService.play(for: item.kana.isEmpty ? item.kanji : item.kana, rate: .normal)
    }
}

/// Vocabulary 清單的純資料轉換與排序邏輯。
private struct Processor {
    /// 將 API model 轉成畫面 model，並套用收藏狀態。
    /// - Parameters:
    ///   - vocabulary: API 回傳的單字清單。
    ///   - level: 目前選取的 JLPT 等級。
    ///   - favorites: 已收藏的單字 key 集合。
    /// - Returns: 套用收藏狀態後的畫面 model。
    func makeItems(
        vocabulary: [Vocabulary],
        level: JLPTLevel,
        favorites: Set<String>
    ) -> [VocabularyCardView.StateItem] {
        vocabulary.map { item in
            var item = VocabularyCardView.StateItem(
                level: level,
                kanji: item.word,
                kana: item.furigana,
                romaji: item.romaji
            )

            item.isFavorite = favorites.contains(item.id)

            return item
        }
    }

    /// 依搜尋條件篩選後，將收藏項目排在前方。
    /// - Parameters:
    ///   - items: 目標清單。
    ///   - query: 目前搜尋文字。
    /// - Returns: 篩選與排序後的清單。
    @concurrent
    func filteredAndSortedItems(
        from items: [VocabularyCardView.StateItem],
        query: String
    ) async -> [VocabularyCardView.StateItem] {
        sortByFavorite(filter(items: items, query: query))
    }

    /// 依照搜尋條件回傳篩選結果。
    /// - Parameters:
    ///   - items: 目標清單。
    ///   - query: 目前搜尋文字。
    /// - Returns: 經過搜尋條件篩選後的清單。
    private func filter(
        items: [VocabularyCardView.StateItem],
        query: String
    ) -> [VocabularyCardView.StateItem] {
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

    /// 將收藏項目排在前面，並保留同群組內的原始順序。
    /// - Parameter items: 目標清單。
    /// - Returns: 收藏優先排序後的清單。
    private func sortByFavorite(_ items: [VocabularyCardView.StateItem]) -> [VocabularyCardView.StateItem] {
        var favoriteItems: [VocabularyCardView.StateItem] = []
        var otherItems: [VocabularyCardView.StateItem] = []

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
}
