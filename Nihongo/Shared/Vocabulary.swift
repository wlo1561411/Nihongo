import FMFoundation
import SwiftUI

/// JLPT vocabulary 的詞性分類。
enum PartOfSpeech: String, CaseIterable, Codable, Equatable {
    /// 名詞。
    case n = "Noun"
    /// 動詞。
    case v = "Verb"
    /// い形容詞。
    case adjI = "i-Adjective"
    /// な形容詞。
    case adjNa = "na-Adjective"
    /// 副詞。
    case adv = "Adverb"
    /// 助動詞。
    case auxV = "Auxiliary Verb"
    /// 接續詞。
    case conj = "Conjunction"
    /// 助數詞。
    case ctr = "Counter"
    /// 慣用表現。
    case expr = "Expression"
    /// 感嘆詞。
    case int = "Interjection"
    /// 數詞。
    case num = "Numeral"
    /// 其他詞性。
    case oth = "Other"
    /// 助詞。
    case prt = "Particle"
    /// 接頭詞。
    case pref = "Prefix"
    /// 連體詞。
    case pren = "Prenominal"
    /// 代名詞。
    case pron = "Pronoun"
    /// 接尾詞。
    case suf = "Suffix"

    var abbreviation: String {
        switch self {
        case .adjI:
            "adj-い"
        case .adjNa:
            "adj-な"
        default:
            "\(self)"
        }
    }

    var primaryColor: Color {
        switch self {
        case .n:
            .accentBluePrimary
        case .v:
            .accentGreenPrimary
        case .adjI,
             .adjNa:
            .accentRedPrimary
        case .adv:
            .accentPinkPrimary
        case .num:
            .accentOrangePrimary
        case .auxV,
             .conj,
             .ctr,
             .expr,
             .int:
            .accentPurplePrimary
        case .oth:
            .accentTealPrimary
        case .prt,
             .pref,
             .pren,
             .pron,
             .suf:
            .accentYellowPrimary
        }
    }

    var secondaryColor: Color {
        switch self {
        case .n:
            .accentBlueSecondary
        case .v:
            .accentGreenSecondary
        case .adjI,
             .adjNa:
            .accentRedSecondary
        case .adv:
            .accentPinkSecondary
        case .num:
            .accentOrangeSecondary
        case .auxV,
             .conj,
             .ctr,
             .expr,
             .int:
            .accentPurpleSecondary
        case .oth:
            .accentTealSecondary
        case .prt,
             .pref,
             .pren,
             .pron,
             .suf:
            .accentYellowSecondary
        }
    }
}

protocol Vocabulary: Sendable, Equatable, Identifiable {
    var word: String { get }
    var furigana: String { get }
    var romaji: String { get }
    var level: JLPTLevel { get }
    var partOfSpeech: [PartOfSpeech] { get }

    func meaning(by language: Language) -> String
    func example(by language: Language) -> String
}

extension Vocabulary {
    var id: String {
        word
    }
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
    @DefaultCodable(.n5)
    var level: JLPTLevel

    var partOfSpeech: [PartOfSpeech] {
        []
    }

    func meaning(by language: Language) -> String {
        meaning
    }

    func example(by language: Language) -> String {
        ""
    }

    init() { }

    init(
        word: String,
        meaning: String,
        furigana: String,
        romaji: String,
        level: JLPTLevel
    ) {
        self.word = word
        self.meaning = meaning
        self.furigana = furigana
        self.romaji = romaji
        self.level = level
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
    @DefaultCodable(.n5)
    var level: JLPTLevel
    @DefaultCodable([], path: "part_of_speech")
    var partOfSpeech: [PartOfSpeech]
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
    struct Example: AutoCodable, Equatable {
        @DefaultCodable("")
        var ja: String
        @DefaultCodable("")
        var zh: String
        @DefaultCodable("")
        var en: String
    }
}
