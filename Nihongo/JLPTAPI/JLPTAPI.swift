import FMFoundation
import Foundation

nonisolated struct JLPTAPI {
    protocol Request: APIRequest { }

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
}

extension JLPTAPI.Request {
    nonisolated var baseURL: URL? {
        URL(string: "https://jlpt-vocab-api.vercel.app")
    }
}
