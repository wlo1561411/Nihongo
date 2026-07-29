import Combine
import SwiftUI

/// 管理 JLPT 等級選擇畫面的狀態與事件。
final class ChooseLevelViewModel: ObservableObject {
    /// 預設顯示的等級卡片清單。
    let cardStates: [LevelCardView.CardState]

    let title: String
    let subTitle: String

    /// 目前選取的等級 ID。
    @Published
    private(set) var selectedLevelID: JLPTLevel

    /// 由外部注入的等級選擇事件。
    private let onSelectLevel: (JLPTLevel) -> Void

    /// 建立等級選擇 ViewModel。
    init(
        title: String,
        subTitle: String,
        cardStates: [LevelCardView.CardState] = ChooseLevelViewModel.defaultLevelCardStates,
        selectedLevelID: JLPTLevel = .n5,
        onSelectLevel: @escaping (JLPTLevel) -> Void
    ) {
        self.title = title
        self.subTitle = subTitle
        self.cardStates = cardStates
        self.selectedLevelID = selectedLevelID
        self.onSelectLevel = onSelectLevel
    }

    /// 處理等級卡片點擊。
    func selectLevel(_ level: LevelCardView.CardState) {
        if selectedLevelID == level.id {
            confirmLevel(level)
        } else {
            selectedLevelID = level.id
        }
    }

    /// 處理等級按鈕點擊。
    func confirmLevel(_ level: LevelCardView.CardState) {
        selectedLevelID = level.id
        onSelectLevel(level.id)
    }

    /// 預設等級卡片清單。
    static let defaultLevelCardStates: [LevelCardView.CardState] = JLPTLevel
        .recommendedOrder
        .map { level in
            LevelCardView.CardState(
                id: level,
                title: "\(level.displayName) - \(level.titleText)",
                subtitle: level.subtitleText,
                badgeText: level.displayName,
                actionTitle: "Start Learning"
            )
        }
}
