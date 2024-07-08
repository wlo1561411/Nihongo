import Foundation

protocol ItemProtocol {
    var value: String { get }
    var description: String { get }
}

extension ItemProtocol {
    var speakText: String {
        var text = value

        let split = text.split(separator: "\n")

        if split.count != 1, let last = split.last {
            text = "\(last)"
        }

        return text.replacingOccurrences(of: "〜", with: "")
    }

    var inputText: String {
        var text = value

        let split = text.split(separator: "\n")

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
