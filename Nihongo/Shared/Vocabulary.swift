import FMFoundation

enum Language: String {
    case ja
    case zh
    case en
}

protocol Vocabulary: Sendable {
    var word: String { get }
    var furigana: String { get }
    var romaji: String { get }
    var level: Int { get }
    var partOfSpeech: [String] { get }

    func meaning(by language: Language) -> String
    func example(by language: Language) -> String
}

struct APIVocabulary: AutoCodable, Vocabulary {
    @DefaultCodable("")
    var word: String
    @DefaultCodable("")
    var meaning: String
    @DefaultCodable("")
    var furigana: String
    @DefaultCodable("")
    var romaji: String
    @DefaultCodable(0)
    var level: Int

    var partOfSpeech: [String] {
        []
    }

    func meaning(by language: Language) -> String {
        meaning
    }

    func example(by language: Language) -> String {
        ""
    }
}

struct LocalVocabulary: AutoCodable, Vocabulary {
    @DefaultCodable("")
    var word: String
    @DefaultCodable("")
    var meaning_zh: String
    @DefaultCodable("")
    var meaning_en: String
    @DefaultCodable("")
    var furigana: String
    @DefaultCodable("")
    var romaji: String
    @DefaultCodable(0)
    var level: Int
    @DefaultCodable([], path: "part_of_speech")
    var partOfSpeech: [String]
    @DefaultCodable(.init())
    var example: Example

    func meaning(by language: Language) -> String {
        switch language {
        case .ja:
            word
        case .zh:
            meaning_zh
        case .en:
            meaning_en
        }
    }

    func example(by language: Language) -> String {
        switch language {
        case .ja:
            example.ja
        case .zh:
            example.zh
        case .en:
            example.en
        }
    }
}

extension LocalVocabulary {
    struct Example: AutoCodable {
        @DefaultCodable("")
        var ja: String
        @DefaultCodable("")
        var zh: String
        @DefaultCodable("")
        var en: String
    }
}
