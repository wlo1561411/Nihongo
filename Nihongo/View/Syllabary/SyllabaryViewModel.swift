import Observation

@MainActor
@Observable
final class SyllabaryViewModel {
    var selectedType: SyllabaryType

    private(set) var sections: [SyllabarySection]

    private let syllabaryStore: SyllabaryStore
    private let voiceService: VoiceService

    init(
        selectedType: SyllabaryType = .hiragana,
        sections: [SyllabarySection] = [],
        syllabaryStore: SyllabaryStore = GojuonSyllabaryStore.shared,
        voiceService: VoiceService = JapaneseVoiceService.shared
    ) {
        self.selectedType = selectedType
        self.sections = sections
        self.syllabaryStore = syllabaryStore
        self.voiceService = voiceService
    }

    func load() async {
        sections = (try? await syllabaryStore.fetch(type: selectedType)) ?? []
    }

    func playVoice(for syllable: any Syllable) {
        voiceService.play(for: syllable.character, mode: .syllable)
    }
}
