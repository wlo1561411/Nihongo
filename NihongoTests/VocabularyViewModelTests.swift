import XCTest
@testable import Nihongo

@MainActor
final class VocabularyViewModelTests: XCTestCase {
    func test_loadVocabulary_filtersByLevel_andAppliesFavorites() async throws {
        let n5Word = try makeVocabulary(word: "先生", meaning: "Teacher", furigana: "せんせい", romaji: "sensei", level: 5)
        let n4Word = try makeVocabulary(word: "会議", meaning: "Meeting", furigana: "かいぎ", romaji: "kaigi", level: 4)
        let favoriteKey = makeStateItem(kanji: "先生", kana: "せんせい", romaji: "sensei").id

        let vocabularyStore = MockVocabularyStore(result: .success([n5Word, n4Word]))
        let favoritesStore = MockFavoritesStore(initialFavorites: [favoriteKey])
        let viewModel = VocabularyViewModel(level: .n5, store: vocabularyStore, favoritesStore: favoritesStore)

        await viewModel.loadVocabulary()

        XCTAssertEqual(vocabularyStore.fetchCallCount, 1)
        XCTAssertEqual(viewModel.vocabularyItems.count, 1)
        XCTAssertEqual(viewModel.vocabularyItems.first?.kanji, "先生")
        XCTAssertEqual(viewModel.vocabularyItems.first?.isFavorite, true)
        XCTAssertEqual(viewModel.currentItems, viewModel.vocabularyItems)
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_loadVocabulary_placesFavoritesFirst() async throws {
        let normalWord = try makeVocabulary(word: "学校", meaning: "School", furigana: "がっこう", romaji: "gakkou", level: 5)
        let favoriteWord = try makeVocabulary(word: "先生", meaning: "Teacher", furigana: "せんせい", romaji: "sensei", level: 5)
        let favoriteKey = makeStateItem(kanji: "先生", kana: "せんせい", romaji: "sensei").id

        let vocabularyStore = MockVocabularyStore(result: .success([normalWord, favoriteWord]))
        let favoritesStore = MockFavoritesStore(initialFavorites: [favoriteKey])
        let viewModel = VocabularyViewModel(level: .n5, store: vocabularyStore, favoritesStore: favoritesStore)

        await viewModel.loadVocabulary()

        XCTAssertEqual(viewModel.vocabularyItems.map(\.kanji), ["学校", "先生"])
        XCTAssertEqual(viewModel.currentItems.map(\.kanji), ["先生", "学校"])
    }

    func test_loadVocabulary_whenInitialItemsExist_shouldNotFetchAgain() async {
        let vocabularyStore = MockVocabularyStore(result: .success([]))
        let favoritesStore = MockFavoritesStore(initialFavorites: [])
        let initialItem = makeStateItem(kanji: "学校", kana: "がっこう", romaji: "School")
        let viewModel = VocabularyViewModel(
            level: .n5,
            store: vocabularyStore,
            favoritesStore: favoritesStore,
            vocabularyItems: [initialItem]
        )

        await viewModel.loadVocabulary()

        XCTAssertEqual(vocabularyStore.fetchCallCount, 0)
        XCTAssertEqual(viewModel.vocabularyItems, [initialItem])
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_updateFilteredItems_filtersByTrimmedCaseInsensitiveQuery() async {
        let item1 = makeStateItem(kanji: "先生", kana: "せんせい", romaji: "Teacher")
        let item2 = makeStateItem(kanji: "会議", kana: "かいぎ", romaji: "Meeting")
        let viewModel = VocabularyViewModel(
            level: .n5,
            store: nil,
            favoritesStore: nil,
            vocabularyItems: [item1, item2]
        )

        viewModel.searchText = "  teacHER  "
        await viewModel.updateFilteredItems()

        XCTAssertEqual(viewModel.currentItems, [item1])
        XCTAssertEqual(viewModel.viewState, .finish)

        viewModel.searchText = "no-match"
        await viewModel.updateFilteredItems()

        XCTAssertEqual(viewModel.currentItems, [])
        XCTAssertEqual(viewModel.viewState, .empty)
    }

    func test_updateFilteredItems_placesFavoritesFirstWithinResults() async {
        let normalItem = makeStateItem(kanji: "先生", kana: "せんせい", romaji: "Teacher")
        let favoriteItem = makeStateItem(
            kanji: "先生達",
            kana: "せんせいたち",
            romaji: "Teachers",
            isFavorite: true
        )
        let viewModel = VocabularyViewModel(
            level: .n5,
            store: nil,
            favoritesStore: nil,
            vocabularyItems: [normalItem, favoriteItem]
        )

        viewModel.searchText = "Teacher"
        await viewModel.updateFilteredItems()

        XCTAssertEqual(viewModel.currentItems, [favoriteItem, normalItem])
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_toggleFavorite_andSaveFavorite_updatesStore() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item = makeStateItem(kanji: "先生", kana: "せんせい", romaji: "Teacher")
        let viewModel = VocabularyViewModel(
            level: .n5,
            store: nil,
            favoritesStore: store,
            vocabularyItems: [item]
        )

        await viewModel.toggleFavorite(for: item)
        viewModel.saveFavorite()

        XCTAssertEqual(viewModel.vocabularyItems.first?.isFavorite, true)
        XCTAssertEqual(store.savedFavorites, [item.id])

        if let toggledItem = viewModel.vocabularyItems.first {
            await viewModel.toggleFavorite(for: toggledItem)
            viewModel.saveFavorite()
        }

        XCTAssertEqual(viewModel.vocabularyItems.first?.isFavorite, false)
        XCTAssertEqual(store.savedFavorites, [])
    }

    func test_toggleFavorite_placesToggledFavoriteFirstInFilteredItems() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item1 = makeStateItem(kanji: "学校", kana: "がっこう", romaji: "School")
        let item2 = makeStateItem(kanji: "先生", kana: "せんせい", romaji: "Teacher")
        let viewModel = VocabularyViewModel(
            level: .n5,
            store: nil,
            favoritesStore: store,
            vocabularyItems: [item1, item2]
        )

        await viewModel.toggleFavorite(for: item2)

        XCTAssertEqual(viewModel.currentItems.map(\.kanji), ["先生", "学校"])
        XCTAssertEqual(viewModel.currentItems.first?.isFavorite, true)
    }
}

private extension VocabularyViewModelTests {
    func makeVocabulary(
        word: String,
        meaning: String,
        furigana: String,
        romaji: String,
        level: Int
    ) throws -> Vocabulary {
        let json = """
        {
          "word": "\(word)",
          "meaning": "\(meaning)",
          "furigana": "\(furigana)",
          "romaji": "\(romaji)",
          "level": \(level)
        }
        """
        let data = Data(json.utf8)
        return try JSONDecoder().decode(Vocabulary.self, from: data)
    }

    func makeStateItem(
        level: JLPTLevel = .n5,
        kanji: String,
        kana: String,
        romaji: String,
        isFavorite: Bool = false
    ) -> VocabularyCardView.StateItem {
        VocabularyCardView.StateItem(
            level: level,
            kanji: kanji,
            kana: kana,
            romaji: romaji,
            isFavorite: isFavorite
        )
    }
}

private final class MockVocabularyStore: VocabularyStore {
    let vocabulary: [Vocabulary] = []
    private let result: Result<[Vocabulary], Error>
    private(set) var fetchCallCount = 0

    init(result: Result<[Vocabulary], Error>) {
        self.result = result
    }

    func fetch(level: JLPTLevel) async throws -> [Vocabulary] {
        fetchCallCount += 1
        return try result.get().filter { $0.level == level.rawValue }
    }
}

private final class MockFavoritesStore: FavoritesStore {
    private let initialFavorites: Set<String>
    private(set) var savedFavorites: Set<String> = []

    init(initialFavorites: Set<String>) {
        self.initialFavorites = initialFavorites
    }

    func loadFavorites() -> Set<String> {
        initialFavorites
    }

    func saveFavorites(_ favorites: Set<String>) {
        savedFavorites = favorites
    }
}
