import Observation

@MainActor
@Observable
final class VocabularyDetailViewModel {
    private(set) var vocabulary: any Vocabulary

    private(set) var isFavorite: Bool

    private let favoritesStore: FavoritesStore?
    private let voiceService: VoiceService

    init(
        vocabulary: any Vocabulary,
        isFavorite: Bool,
        favoritesStore: FavoritesStore? = UserDefaultsFavoritesStore.shared,
        voiceService: VoiceService = JapaneseVoiceService.shared
    ) {
        self.vocabulary = vocabulary
        self.isFavorite = isFavorite
        self.favoritesStore = favoritesStore
        self.voiceService = voiceService
    }

    func toggleFavorite() async {
        isFavorite.toggle()
        await favoritesStore?.execute(key: vocabulary.id, isFavorite: isFavorite)
    }

    func playVoice(for item: any Vocabulary) {
        voiceService.play(for: item.furigana.isEmpty ? item.word : item.furigana, rate: .normal)
    }

    func playVoice(for text: String) {
        voiceService.play(for: text, rate: .normal)
    }
}
