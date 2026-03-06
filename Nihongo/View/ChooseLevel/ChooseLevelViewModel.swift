import Combine
import SwiftUI

/// 管理 JLPT 等級選擇畫面的狀態與事件。
final class ChooseLevelViewModel: ObservableObject {
    /// 預設顯示的等級卡片清單。
    /// - Important: 清單請保持精簡，避免在小螢幕上擁擠。
    let levels: [LevelCardView.StateItem]

    let title: String
    let subTitle: String

    /// 目前選取的等級 ID。
    @Published
    private(set) var selectedLevelID: JLPTLevel

    /// 由外部注入的等級選擇事件。
    private let onSelectLevel: (JLPTLevel) -> Void

    /// 建立等級選擇 ViewModel。
    /// - Parameters:
    ///   - levels: 自訂等級卡片清單。
    ///   - selectedLevelID: 預設選取的等級 ID。
    ///   - onSelectLevel: 點擊確認後回呼選取事件。
    init(
        title: String,
        subTitle: String,
        levels: [LevelCardView.StateItem] = ChooseLevelViewModel.defaultLevels,
        selectedLevelID: JLPTLevel = .n5,
        onSelectLevel: @escaping (JLPTLevel) -> Void
    ) {
        self.title = title
        self.subTitle = subTitle
        self.levels = levels
        self.selectedLevelID = selectedLevelID
        self.onSelectLevel = onSelectLevel
    }

    /// 處理等級卡片點擊。
    /// - Parameter level: 使用者選取的等級。
    func selectLevel(_ level: LevelCardView.StateItem) {
        if selectedLevelID == level.id {
            confirmLevel(level)
        } else {
            selectedLevelID = level.id
        }
    }

    /// 處理等級按鈕點擊。
    /// - Parameter level: 使用者選取的等級。
    func confirmLevel(_ level: LevelCardView.StateItem) {
        selectedLevelID = level.id
        onSelectLevel(level.id)
    }

    /// 預設等級卡片清單。
    static let defaultLevels: [LevelCardView.StateItem] = JLPTLevel.recommendedOrder.map { level in
        LevelCardView.StateItem(
            id: level,
            title: "\(level.displayName) - \(level.titleText)",
            subtitle: level.subtitleText,
            badgeText: level.displayName,
            actionTitle: "Start Learning"
        )
    }
}
