import FMFoundation

protocol Syllable: Sendable, Equatable, Identifiable where ID == String {
    var id: String { get }
    var character: String { get }
    var reading: String { get }
}

extension Syllable {
    var id: String {
        character
    }
}

struct EmptySyllable: Syllable {
    let id: String
    let character = ""
    let reading = ""
}

struct GojuonSyllabary: AutoCodable {
    @DefaultCodable([])
    var basic: [Word]
    @DefaultCodable([])
    var dakuten: [Word]
    @DefaultCodable([])
    var handakuten: [Word]

    init() { }

    init(basic: [Word], dakuten: [Word], handakuten: [Word]) {
        self.basic = basic
        self.dakuten = dakuten
        self.handakuten = handakuten
    }
}

extension GojuonSyllabary {
    struct Word: AutoCodable, Syllable {
        @DefaultCodable("")
        var character: String
        @DefaultCodable("")
        var romaji: String

        var reading: String {
            romaji
        }
    }
}
