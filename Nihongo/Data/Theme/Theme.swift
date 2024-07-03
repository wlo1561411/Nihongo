import Foundation

typealias ItemMap = [String: ItemProtocol]

protocol Theme {
    var title: String { get }
    var allItems: ItemMap { get }
    var voiceRate: Float { get }

    func shuffled(count: Int) -> ItemMap
}

extension Theme {
    func shuffled(count: Int = 15) -> ItemMap {
        let shuffledKeys = allItems.keys.shuffled()
        let selectedKeys = shuffledKeys.prefix(count)
        var selectedCards: [String: ItemProtocol] = [:]
        for key in selectedKeys {
            if let item = allItems[key] {
                selectedCards[key] = item
            }
        }
        return selectedCards
    }
}
