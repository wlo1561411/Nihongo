import Observation

@MainActor
@Observable
final class VocabularyDetailViewModel {
    private(set) var word: String
    private(set) var furigana: String
    private(set) var romaji: String
    private(set) var meaning: String
    private(set) var example: String
    private(set) var translatedExample: String
    private(set) var partOfSpeech: [PartOfSpeech]
    private(set) var isFavorite: Bool

    private let upcomingMaximum: Int
    private let upcomingVocabularies: [any Vocabulary]
    private(set) var upcomingVocabularyCardStates: [VocabularyCardsView.CardState] = []

    private let favoritesStore: FavoritesStore?
    private let voiceService: VoiceService

    init(
        word: String,
        furigana: String,
        romaji: String,
        meaning: String,
        example: String,
        translatedExample: String,
        partOfSpeech: [PartOfSpeech],
        isFavorite: Bool,
        upcomingMaximum: Int = 8,
        upcomingVocabularies: [any Vocabulary],
        favoritesStore: FavoritesStore? = UserDefaultsFavoritesStore.shared,
        voiceService: VoiceService = JapaneseVoiceService.shared
    ) {
        self.word = word
        self.furigana = furigana
        self.romaji = romaji
        self.meaning = meaning
        self.example = example
        self.translatedExample = translatedExample
        self.partOfSpeech = partOfSpeech
        self.isFavorite = isFavorite
        self.upcomingMaximum = upcomingMaximum
        self.upcomingVocabularies = upcomingVocabularies
        self.favoritesStore = favoritesStore
        self.voiceService = voiceService
    }

    func load() async {
        guard upcomingVocabularyCardStates.isEmpty else {
            return
        }

        let favorites = await favoritesStore?.loadFavorites() ?? []
        upcomingVocabularyCardStates = makeUpcomingCardStates(currentId: word, favorites: favorites)
    }

    func reload(for item: VocabularyCardsView.CardState) async {
        guard let vocabulary = upcomingVocabularies.first(where: { $0.id == item.id }) else {
            return
        }

        let favorites = await favoritesStore?.loadFavorites() ?? []
        let upcoming = makeUpcomingCardStates(currentId: vocabulary.id, favorites: favorites)

        word = vocabulary.word
        furigana = vocabulary.furigana
        romaji = vocabulary.romaji
        meaning = vocabulary.meaning(by: .zh)
        example = vocabulary.example(by: .ja)
        translatedExample = vocabulary.example(by: .zh)
        partOfSpeech = vocabulary.partOfSpeech
        isFavorite = favorites.contains(vocabulary.id)
        upcomingVocabularyCardStates = upcoming
    }

    private func makeUpcomingCardStates(currentId: String, favorites: Set<String>) -> [VocabularyCardsView.CardState] {
        var cards = [VocabularyCardsView.CardState]()

        for vocabulary in upcomingVocabularies.shuffled() where vocabulary.id != currentId {
            if cards.count < upcomingMaximum {
                cards.append(.init(vocabulary: vocabulary, favorites: favorites))
            } else {
                break
            }
        }

        return cards
    }
}

// MARK: - Action

extension VocabularyDetailViewModel {
    func toggleFavorite() async {
        isFavorite.toggle()
        await favoritesStore?.execute(key: word, isFavorite: isFavorite)
    }

    func toggleFavorite(for item: VocabularyCardsView.CardState) async {
        guard let index = upcomingVocabularyCardStates.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        upcomingVocabularyCardStates[index].isFavorite.toggle()

        await favoritesStore?
            .execute(
                key: item.id,
                isFavorite: upcomingVocabularyCardStates[index].isFavorite
            )
    }

    func playWordVoice() {
        voiceService.play(for: furigana.isEmpty ? word : furigana, mode: .word)
    }

    func playExampleVoice() {
        voiceService.play(for: example, mode: .sentence)
    }
}
