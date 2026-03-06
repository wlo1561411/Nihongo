import XCTest
@testable import Nihongo

@MainActor
final class VocabularyViewModelTests: XCTestCase {
    func test_loadVocabulary_filtersByLevel_andAppliesFavorites() async throws {
        let n5Word = try makeVocabulary(word: "先生", meaning: "Teacher", furigana: "せんせい", romaji: "sensei", level: 5)
        let n4Word = try makeVocabulary(word: "会議", meaning: "Meeting", furigana: "かいぎ", romaji: "kaigi", level: 4)
        let favoriteKey = FavoriteKey.make(word: "先生", furigana: "せんせい", level: .n5)

        let repository = MockVocabularyRepository(result: .success([n5Word, n4Word]))
        let store = MockFavoritesStore(initialFavorites: [favoriteKey])
        let viewModel = VocabularyViewModel(level: .n5, repository: repository, favoritesStore: store)

        await viewModel.loadVocabulary()

        XCTAssertEqual(repository.fetchCallCount, 1)
        XCTAssertEqual(viewModel.vocabularyItems.count, 1)
        XCTAssertEqual(viewModel.vocabularyItems.first?.kanji, "先生")
        XCTAssertEqual(viewModel.vocabularyItems.first?.isFavorite, true)
        XCTAssertEqual(viewModel.filteredItems, viewModel.vocabularyItems)
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_loadVocabulary_whenInitialItemsExist_shouldNotFetchAgain() async {
        let repository = MockVocabularyRepository(result: .success([]))
        let store = MockFavoritesStore(initialFavorites: [])
        let initialItem = VocabularyCardView.StateItem(
            kanji: "学校",
            kana: "がっこう",
            romaji: "School",
            isFavorite: false,
            favoriteKey: FavoriteKey.make(word: "学校", furigana: "がっこう", level: .n5)
        )
        let viewModel = VocabularyViewModel(
            level: .n5,
            repository: repository,
            favoritesStore: store,
            vocabularyItems: [initialItem]
        )

        await viewModel.loadVocabulary()

        XCTAssertEqual(repository.fetchCallCount, 0)
        XCTAssertEqual(viewModel.vocabularyItems, [initialItem])
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_updateFilteredItems_filtersByTrimmedCaseInsensitiveQuery() async {
        let item1 = VocabularyCardView.StateItem(
            kanji: "先生",
            kana: "せんせい",
            romaji: "Teacher",
            isFavorite: false,
            favoriteKey: FavoriteKey.make(word: "先生", furigana: "せんせい", level: .n5)
        )
        let item2 = VocabularyCardView.StateItem(
            kanji: "会議",
            kana: "かいぎ",
            romaji: "Meeting",
            isFavorite: false,
            favoriteKey: FavoriteKey.make(word: "会議", furigana: "かいぎ", level: .n5)
        )
        let viewModel = VocabularyViewModel(
            level: .n5,
            repository: nil,
            favoritesStore: nil,
            vocabularyItems: [item1, item2]
        )

        viewModel.searchText = "  teacHER  "
        await viewModel.updateFilteredItems()

        XCTAssertEqual(viewModel.filteredItems, [item1])
        XCTAssertEqual(viewModel.viewState, .finish)

        viewModel.searchText = "no-match"
        await viewModel.updateFilteredItems()

        XCTAssertEqual(viewModel.filteredItems, [])
        XCTAssertEqual(viewModel.viewState, .empty)
    }

    func test_toggleFavorite_andSaveFavorite_updatesStore() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item = VocabularyCardView.StateItem(
            kanji: "先生",
            kana: "せんせい",
            romaji: "Teacher",
            isFavorite: false,
            favoriteKey: FavoriteKey.make(word: "先生", furigana: "せんせい", level: .n5)
        )
        let viewModel = VocabularyViewModel(
            level: .n5,
            repository: nil,
            favoritesStore: store,
            vocabularyItems: [item]
        )

        await viewModel.toggleFavorite(for: item)
        viewModel.saveFavorite()

        XCTAssertEqual(viewModel.vocabularyItems.first?.isFavorite, true)
        XCTAssertEqual(store.savedFavorites, [item.favoriteKey])

        if let toggledItem = viewModel.vocabularyItems.first {
            await viewModel.toggleFavorite(for: toggledItem)
            viewModel.saveFavorite()
        }

        XCTAssertEqual(viewModel.vocabularyItems.first?.isFavorite, false)
        XCTAssertEqual(store.savedFavorites, [])
    }
}

private extension VocabularyViewModelTests {
    func makeVocabulary(
        word: String,
        meaning: String,
        furigana: String,
        romaji: String,
        level: Int
    ) throws -> JLPTAPI.Vocabulary {
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
        return try JSONDecoder().decode(JLPTAPI.Vocabulary.self, from: data)
    }
}

private final class MockVocabularyRepository: VocabularyRepository {
    let vocabulary: [JLPTAPI.Vocabulary] = []
    private let result: Result<[JLPTAPI.Vocabulary], Error>
    private(set) var fetchCallCount = 0

    init(result: Result<[JLPTAPI.Vocabulary], Error>) {
        self.result = result
    }

    func fetch() async throws -> [JLPTAPI.Vocabulary] {
        fetchCallCount += 1
        return try result.get()
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
