import Foundation

protocol Theme {
    typealias Section = (title: String, items: [ItemProtocol])

    var title: String { get }
    var items: [ItemProtocol] { get }
    var voicePlaybackRate: Float { get }
    var numberOfRowsInGrid: Int { get }

    func shuffled(count: Int) -> [ItemProtocol]

    func sectionsForGrid() -> [Section]
}

extension Theme {
    var voicePlaybackRate: Float {
        0.2
    }

    var numberOfRowsInGrid: Int {
        1
    }

    func shuffled(count: Int = 15) -> [ItemProtocol] {
        Array(items.shuffled().prefix(count))
    }
}
