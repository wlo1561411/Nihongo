import Foundation

struct SyllabaryItem: ItemProtocol {
    let value: String
    let description: String
}

protocol JapaneseSyllabaryTheme: Theme {
    typealias Section = (title: String, items: [ItemProtocol])

    var normalItems: [ItemProtocol] { get }
    /// 濁音
    var voicedItem: [ItemProtocol] { get }
    /// 半濁音
    var semiVoicedItem: [ItemProtocol] { get }
}

extension JapaneseSyllabaryTheme {
    var voicePlaybackRate: Float {
        0.1
    }

    var items: [ItemProtocol] {
        normalItems + voicedItem + semiVoicedItem
    }
}
