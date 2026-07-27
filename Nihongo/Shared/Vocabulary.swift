import FMFoundation

struct Vocabulary: AutoCodable, Sendable {
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
}
