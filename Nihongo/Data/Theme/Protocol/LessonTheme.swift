import Foundation

struct LessonItem: ItemProtocol {
    let value: String
    var hanValue: String = ""
    let description: String
}

protocol LessonTheme: Theme {
    /// 單字
    var vocabularyItems: [ItemProtocol] { get }
    /// 招呼用語
    var greetingPhrasesItems: [ItemProtocol] { get }
    /// 表現文型
    var sentencePatternsItems: [ItemProtocol] { get }
}

extension LessonTheme {
    var items: [ItemProtocol] {
        vocabularyItems + greetingPhrasesItems + sentencePatternsItems
    }
}
