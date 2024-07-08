import Foundation

protocol LessonTheme: Theme {
    /// 單字
    var vocabularyItems: [ItemProtocol] { get }
    /// 招呼用語
    var greetingPhrasesItem: [ItemProtocol] { get }
    /// 表現文型
    var sentencePatternsItem: [ItemProtocol] { get }
}

extension LessonTheme {
    var items: [ItemProtocol] {
        vocabularyItems + greetingPhrasesItem + sentencePatternsItem
    }

    var numberOfRowsInGrid: Int {
        1
    }

    func sectionsForGrid() -> [Section] {
        var section = [Section]()

        section.append(("單字", vocabularyItems))
        section.append(("招呼用語", greetingPhrasesItem))
        section.append(("表現文型", sentencePatternsItem))

        return section
    }
}
