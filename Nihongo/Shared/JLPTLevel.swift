import Foundation

/// JLPT 等級定義，提供一致的顯示與資料對接格式。
enum JLPTLevel: Int, CaseIterable, Identifiable, Sendable {
    /// N1（最高等級）。
    case n1 = 1
    /// N2。
    case n2 = 2
    /// N3。
    case n3 = 3
    /// N4。
    case n4 = 4
    /// N5（入門等級）。
    case n5 = 5

    /// diff 使用的穩定識別。
    var id: Int { rawValue }

    /// 顯示用字串，例如 `N5`。
    var displayName: String { "N\(rawValue)" }

    /// 等級標題文字（英文）。
    var titleText: String {
        switch self {
        case .n5:
            "Beginner"
        case .n4:
            "Elementary"
        case .n3:
            "Intermediate"
        case .n2:
            "Pre-Advanced"
        case .n1:
            "Advanced"
        }
    }

    /// 等級副標題文字（英文）。
    var subtitleText: String {
        switch self {
        case .n5:
            "Basic expressions and sentences"
        case .n4:
            "Everyday topics and basic kanji"
        case .n3:
            "Daily life situations and reading"
        case .n2:
            "Business and specialized topics"
        case .n1:
            "Complex abstract concepts"
        }
    }

    /// 推薦顯示順序（由入門到高階）。
    static let recommendedOrder: [JLPTLevel] = [.n5, .n4, .n3, .n2, .n1]

    /// 範圍中最高等級。
    static let highest: JLPTLevel = .n1

    /// 範圍中最低等級。
    static let lowest: JLPTLevel = .n5
}
