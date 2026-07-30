@testable import Nihongo
import XCTest

@MainActor
final class VocabulariesViewModelTests: XCTestCase {
    func test_loadVocabulary_filtersByLevelAndAppliesFavorites() async {
        let n5Word = makeVocabulary(word: "先生", meaning: "Teacher", furigana: "せんせい", romaji: "sensei", level: .n5)
        let n4Word = makeVocabulary(word: "会議", meaning: "Meeting", furigana: "かいぎ", romaji: "kaigi", level: .n4)
        let favoriteKey = makeStateItem(word: "先生", furigana: "せんせい", romaji: "sensei").id

        let vocabularyStore = MockVocabularyStore(result: .success([n5Word, n4Word]))
        let favoritesStore = MockFavoritesStore(initialFavorites: [favoriteKey])
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: vocabularyStore,
            favoritesStore: favoritesStore
        )

        await viewModel.load()

        XCTAssertEqual(vocabularyStore.fetchCallCount, 1)
        XCTAssertEqual(viewModel.vocabularies.map(\.word), ["先生"])
        XCTAssertEqual(viewModel.vocabularyCardStates.map(\.word), ["先生"])
        XCTAssertEqual(viewModel.vocabularyCardStates.first?.isFavorite, true)
        XCTAssertEqual(viewModel.currentCardStates, viewModel.vocabularyCardStates)
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_loadVocabulary_placesFavoritesFirstInCurrentItemsOnly() async {
        let normalWord = makeVocabulary(word: "学校", meaning: "School", furigana: "がっこう", romaji: "gakkou", level: .n5)
        let favoriteWord = makeVocabulary(word: "先生", meaning: "Teacher", furigana: "せんせい", romaji: "sensei", level: .n5)
        let favoriteKey = makeStateItem(word: "先生", furigana: "せんせい", romaji: "sensei").id

        let vocabularyStore = MockVocabularyStore(result: .success([normalWord, favoriteWord]))
        let favoritesStore = MockFavoritesStore(initialFavorites: [favoriteKey])
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: vocabularyStore,
            favoritesStore: favoritesStore
        )

        await viewModel.load()

        XCTAssertEqual(viewModel.vocabularyCardStates.map(\.word), ["学校", "先生"])
        XCTAssertEqual(viewModel.currentCardStates.map(\.word), ["先生", "学校"])
    }

    func test_loadVocabulary_whenInitialItemsExistDoesNotFetchAgainAndRefreshesFavorites() async {
        let vocabularyStore = MockVocabularyStore(result: .success([]))
        let favoritesStore = MockFavoritesStore(initialFavorites: [])
        let initialItem = makeStateItem(word: "学校", furigana: "がっこう", romaji: "School", isFavorite: true)
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: vocabularyStore,
            favoritesStore: favoritesStore,
            vocabularyCardStates: [initialItem]
        )

        await viewModel.load()

        XCTAssertEqual(vocabularyStore.fetchCallCount, 0)
        XCTAssertEqual(viewModel.vocabularyCardStates.first?.isFavorite, false)
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_updateSearchItems_filtersByTrimmedCaseInsensitiveQuery() async {
        let item1 = makeStateItem(word: "先生", furigana: "せんせい", romaji: "Teacher")
        let item2 = makeStateItem(word: "会議", furigana: "かいぎ", romaji: "Meeting")
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: nil,
            vocabularyCardStates: [item1, item2]
        )

        viewModel.searchText = "  teacHER  "
        await viewModel.searching()

        XCTAssertEqual(viewModel.currentCardStates, [item1])
        XCTAssertEqual(viewModel.vocabularyCardStates, [item1, item2])
        XCTAssertEqual(viewModel.viewState, .finish)

        viewModel.searchText = "no-match"
        await viewModel.searching()

        XCTAssertEqual(viewModel.currentCardStates, [])
        XCTAssertEqual(viewModel.vocabularyCardStates, [item1, item2])
        XCTAssertEqual(viewModel.viewState, .empty)
    }

    func test_updateSearchItems_placesFavoritesFirstWithinResults() async {
        let normalItem = makeStateItem(word: "先生", furigana: "せんせい", romaji: "Teacher")
        let favoriteItem = makeStateItem(
            word: "先生達",
            furigana: "せんせいたち",
            romaji: "Teachers",
            isFavorite: true
        )
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: nil,
            vocabularyCardStates: [normalItem, favoriteItem]
        )

        viewModel.searchText = "Teacher"
        await viewModel.searching()

        XCTAssertEqual(viewModel.currentCardStates, [favoriteItem, normalItem])
        XCTAssertEqual(viewModel.viewState, .finish)
    }

    func test_toggleFavorite_updatesStoreImmediately() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item = makeStateItem(word: "先生", furigana: "せんせい", romaji: "Teacher")
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: store,
            vocabularyCardStates: [item]
        )

        await viewModel.toggleFavorite(for: item)
        let addedFavorites = await store.loadFavorites()

        XCTAssertEqual(viewModel.vocabularyCardStates.first?.isFavorite, true)
        XCTAssertEqual(addedFavorites, [item.id])

        if let toggledItem = viewModel.vocabularyCardStates.first {
            await viewModel.toggleFavorite(for: toggledItem)
        }
        let removedFavorites = await store.loadFavorites()

        XCTAssertEqual(viewModel.vocabularyCardStates.first?.isFavorite, false)
        XCTAssertEqual(removedFavorites, [])
    }

    func test_toggleFavorite_placesToggledFavoriteFirstInCurrentItems() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item1 = makeStateItem(word: "学校", furigana: "がっこう", romaji: "School")
        let item2 = makeStateItem(word: "先生", furigana: "せんせい", romaji: "Teacher")
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: store,
            vocabularyCardStates: [item1, item2]
        )

        await viewModel.toggleFavorite(for: item2)

        XCTAssertEqual(viewModel.vocabularyCardStates.map(\.word), ["学校", "先生"])
        XCTAssertEqual(viewModel.currentCardStates.map(\.word), ["先生", "学校"])
        XCTAssertEqual(viewModel.currentCardStates.first?.isFavorite, true)
    }

    func test_refreshFavoriteStates_appliesExternalStoreChanges() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item1 = makeStateItem(word: "学校", furigana: "がっこう", romaji: "School")
        let item2 = makeStateItem(word: "先生", furigana: "せんせい", romaji: "Teacher")
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: store,
            vocabularyCardStates: [item1, item2]
        )

        await store.addFavorite(item2.id)
        await viewModel.refreshFavorites()

        XCTAssertEqual(viewModel.vocabularyCardStates.map(\.word), ["学校", "先生"])
        XCTAssertEqual(viewModel.vocabularyCardStates.first(where: { $0.id == item2.id })?.isFavorite, true)
        XCTAssertEqual(viewModel.currentCardStates.map(\.word), ["先生", "学校"])
    }

    func test_refreshFavoriteStates_whenSearchingKeepsFullVocabularySource() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item1 = makeStateItem(word: "学校", furigana: "がっこう", romaji: "School")
        let item2 = makeStateItem(word: "先生", furigana: "せんせい", romaji: "Teacher")
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: store,
            vocabularyCardStates: [item1, item2]
        )

        viewModel.searchText = "Teacher"
        await viewModel.searching()
        await store.addFavorite(item1.id)
        await viewModel.refreshFavorites()

        XCTAssertEqual(viewModel.vocabularyCardStates.count, 2)
        XCTAssertEqual(viewModel.vocabularyCardStates.first(where: { $0.id == item1.id })?.isFavorite, true)
        XCTAssertEqual(viewModel.currentCardStates.map(\.word), ["先生"])
    }

    func test_updateSearchItemsDoesNotOverwriteFavoriteStateRefreshedDuringDebounce() async {
        let store = MockFavoritesStore(initialFavorites: [])
        let item1 = makeStateItem(word: "学校", furigana: "がっこう", romaji: "School")
        let item2 = makeStateItem(word: "先生", furigana: "せんせい", romaji: "Teacher")
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: store,
            vocabularyCardStates: [item1, item2]
        )

        let searchTask = Task {
            await viewModel.searching()
        }

        try? await Task.sleep(for: .milliseconds(100))
        await store.addFavorite(item2.id)
        await viewModel.refreshFavorites()
        await searchTask.value

        XCTAssertEqual(viewModel.vocabularyCardStates.first(where: { $0.id == item2.id })?.isFavorite, true)
        XCTAssertEqual(viewModel.currentCardStates.map(\.word), ["先生", "学校"])
        XCTAssertEqual(viewModel.currentCardStates.first?.isFavorite, true)
    }

    func test_makeDetailViewModelUsesOriginalVocabularySource() async {
        let vocabulary = makeVocabulary(word: "先生", meaning: "Teacher", furigana: "せんせい", romaji: "sensei", level: .n5)
        let vocabularyStore = MockVocabularyStore(result: .success([vocabulary]))
        let viewModel = VocabulariesViewModel(
            level: .n5,
            vocabularyStore: vocabularyStore,
            favoritesStore: nil
        )

        await viewModel.load()

        guard let item = viewModel.currentCardStates.first,
              let detailViewModel = viewModel.makeDetailViewModel(for: item)
        else {
            return XCTFail("Expected detail view model.")
        }

        XCTAssertEqual(detailViewModel.word, "先生")
        XCTAssertEqual(detailViewModel.isFavorite, false)
    }
}

extension VocabulariesViewModelTests {
    private func makeVocabulary(
        word: String,
        meaning: String,
        furigana: String,
        romaji: String,
        level: JLPTLevel
    ) -> any Vocabulary {
        MockVocabulary(
            word: word,
            meaning: meaning,
            furigana: furigana,
            romaji: romaji,
            level: level
        )
    }

    private func makeStateItem(
        level: JLPTLevel = .n5,
        word: String,
        furigana: String,
        romaji: String,
        isFavorite: Bool = false
    ) -> VocabularyCardsView.CardState {
        VocabularyCardsView.CardState(
            level: level,
            word: word,
            furigana: furigana,
            romaji: romaji,
            meaning: romaji,
            isFavorite: isFavorite
        )
    }
}

private struct MockVocabulary: Vocabulary {
    let word: String
    let meaning: String
    let furigana: String
    let romaji: String
    let level: JLPTLevel
    let partOfSpeech: [PartOfSpeech] = []

    func meaning(by language: Language) -> String {
        meaning
    }

    func example(by language: Language) -> String {
        ""
    }
}

private final class MockVocabularyStore: VocabularyStore {
    private let result: Result<[any Vocabulary], Error>
    private(set) var fetchCallCount = 0

    init(result: Result<[any Vocabulary], Error>) {
        self.result = result
    }

    func fetch(level: JLPTLevel) async throws -> [any Vocabulary] {
        fetchCallCount += 1
        return try result.get().filter { $0.level == level }
    }
}

private actor MockFavoritesStore: FavoritesStore {
    private var favorites: Set<String>

    init(initialFavorites: Set<String>) {
        self.favorites = initialFavorites
    }

    func loadFavorites() async -> Set<String> {
        favorites
    }

    func isFavorited(_ key: String) async -> Bool {
        favorites.contains(key)
    }

    func addFavorite(_ key: String) async {
        favorites.insert(key)
    }

    func removeFavorite(_ key: String) async {
        favorites.remove(key)
    }
}
