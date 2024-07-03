import Foundation

protocol Theme {
    var title: String { get }
    var allItems: [any ItemProtocol] { get }
    var voiceRate: Float { get }

    func shuffled(count: Int) -> [any ItemProtocol]
}

extension Theme {
    func shuffled(count: Int = 15) -> [any ItemProtocol] {
        Array(allItems.shuffled().prefix(count))
    }
}
