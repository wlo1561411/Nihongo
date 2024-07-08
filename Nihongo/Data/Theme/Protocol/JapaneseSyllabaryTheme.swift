import Foundation

protocol JapaneseSyllabaryTheme: Theme {
    var normalItems: [ItemProtocol] { get }
    /// 濁音
    var voicedItem: [ItemProtocol] { get }
    /// 半濁音
    var semiVoicedItem: [ItemProtocol] { get }
}

extension JapaneseSyllabaryTheme {
    var items: [ItemProtocol] {
        normalItems + voicedItem + semiVoicedItem
    }

    var numberOfRowsInGrid: Int {
        5
    }

    func sectionsForGrid() -> [Section] {
        var section = [Section]()

        let sort: [String] = [
            "a", "i", "u", "e", "o",
            "ka", "ki", "ku", "ke", "ko",
            "sa", "shi", "su", "se", "so",
            "ta", "chi", "tsu", "te", "to",
            "na", "ni", "nu", "ne", "no",
            "ha", "hi", "fu", "he", "ho",
            "ma", "mi", "mu", "me", "mo",
            "ya", "", "yu", "", "yo",
            "ra", "ri", "ru", "re", "ro",
            "wa", "", "", "", "wo",
            "n", "", "", "", ""
        ]

        let group = Dictionary(grouping: normalItems, by: \.description).compactMapValues(\.first)

        var result = [ItemProtocol]()

        for item in sort {
            if item.isEmpty {
                result.append(Item(value: "", description: ""))
            }
            else if let mapped = group[item] {
                result.append(mapped)
            }
        }

        section.append(("", result))
        section.append(("濁音", voicedItem))
        section.append(("半濁音", semiVoicedItem))

        return section
    }
}
