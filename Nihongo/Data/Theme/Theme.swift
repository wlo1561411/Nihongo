import Foundation

protocol Theme {
    var title: String { get }
    var items: [ItemProtocol] { get }
    var voicePlaybackRate: Float { get }

    func shuffled(count: Int) -> [ItemProtocol]
}

extension Theme {
    var voicePlaybackRate: Float {
        0.2
    }

    func shuffled(count: Int = 15) -> [ItemProtocol] {
        Array(items.shuffled().prefix(count))
    }
}
