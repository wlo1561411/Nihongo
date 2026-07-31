import FMFoundation
import Foundation

enum SyllabaryType: String, Identifiable, CaseIterable {
    case hiragana
    case katakana

    var id: String {
        rawValue
    }

    var displayName: String {
        rawValue.capitalized
    }
}

struct SyllabarySection {
    let title: String
    let syllables: [any Syllable]
}

protocol SyllabaryStore {
    func fetch(type: SyllabaryType) async throws -> [SyllabarySection]
}

actor GojuonSyllabaryStore: SyllabaryStore {
    static let shared = GojuonSyllabaryStore()

    private let logService: LogService

    private(set) var hiragana: [SyllabarySection] = []
    private(set) var katakana: [SyllabarySection] = []

    private init(logService: LogService = LoggerService.shared) {
        self.logService = logService
    }

    func fetch(type: SyllabaryType) async throws -> [SyllabarySection] {
        switch type {
        case .hiragana:
            if !hiragana.isEmpty {
                return hiragana
            }
            hiragana = try makeSections(type: type)
            return hiragana
        case .katakana:
            if !katakana.isEmpty {
                return katakana
            }
            katakana = try makeSections(type: type)
            return katakana
        }
    }

    private func makeSections(type: SyllabaryType) throws -> [SyllabarySection] {
        let syllabary = try load(type: type)

        return [
            .init(title: "", syllables: sort(syllabary.basic)),
            .init(title: "Dakuten", syllables: syllabary.dakuten),
            .init(title: "Handakuten", syllables: syllabary.handakuten),
        ]
    }

    private func sort(_ syllables: [any Syllable]) -> [any Syllable] {
        let sort: [String] = [
            "a", "i", "u", "e", "o",
            "ka", "ki", "ku", "ke", "ko",
            "sa", "shi", "su", "se", "so",
            "ta", "chi", "tsu", "te", "to",
            "na", "ni", "nu", "ne", "no",
            "ha", "hi", "fu", "he", "ho",
            "ma", "mi", "mu", "me", "mo",
            "ya", "", "yu", "", "yo",
            "ra", "ri", "ru", "re", "ro",
            "wa", "", "", "", "wo",
            "", "", "n", "", "",
        ]

        let groupedSyllables = Dictionary(grouping: syllables, by: \.reading)
            .compactMapValues(\.first)

        return sort.enumerated().map { index, reading in
            guard !reading.isEmpty else {
                return EmptySyllable(id: "empty-\(index)")
            }

            return groupedSyllables[reading] ?? EmptySyllable(id: "missing-\(reading)")
        }
    }

    private func load(type: SyllabaryType) throws -> GojuonSyllabary {
        guard let url = Bundle.main.url(forResource: type.rawValue, withExtension: "json")
        else {
            logService.error("載入 \(type) 失敗")
            return .init(basic: [], dakuten: [], handakuten: [])
        }

        let jsonData = try Data(contentsOf: url)
        let syllabary = try JSONDecoder().decode(GojuonSyllabary.self, from: jsonData)

        logService.debug("載入 \(type) 成功")

        return syllabary
    }
}
