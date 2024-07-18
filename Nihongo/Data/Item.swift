import Foundation

protocol ItemProtocol {
    var value: String { get }
    var description: String { get }
}

extension ItemProtocol {
    var displayText: String {
        value.replacingOccurrences(of: "　", with: "\n")
    }

    var inputText: String {
        var text = value

        let split = text.split(separator: "　")

        if split.count != 1, let first = split.first {
            text = "\(first)"
        }

        return text.replacingOccurrences(of: "〜", with: "")
    }
}

struct Item: ItemProtocol {
    let value: String
    let description: String
}
