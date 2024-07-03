import Foundation

protocol ItemProtocol {
    var value: String { get }
    var description: String { get }
}

struct Item: ItemProtocol {
    let value: String
    let description: String
}
