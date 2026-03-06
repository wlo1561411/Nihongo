import Combine
import FMFoundation
import SwiftUI

/// 集中管理 App 全域狀態的物件。
/// - Note: 目前僅管理 onboarding 流程的首次啟動旗標。
final class AppState: ObservableObject {
    /// 是否為首次啟動，用於決定顯示 onboarding 或主畫面。
    @Published
    var isFirstLaunch: Bool {
        didSet {
            UserDefaults.isFirstLaunch = isFirstLaunch
        }
    }

    /// 建立 AppState 並載入目前的首次啟動狀態。
    init(isFirstLaunch: Bool = UserDefaults.isFirstLaunch) {
        self.isFirstLaunch = isFirstLaunch
    }
}

extension UserDefaults {
    @UserDefault("isFirstLaunch")
    fileprivate static var isFirstLaunch = true
}
