import SwiftUI
import UIKit

@main
struct NihongoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    /// 管理 app 的全域狀態（含 onboarding 流程）。
    @StateObject
    private var appState = AppState()

    /// 統一管理導覽路徑的 Router。
    @StateObject
    private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            if appState.isFirstLaunch {
                OnboardingView()
            } else {
                MainTabView()
            }
        }
        .environmentObject(appState)
        .environmentObject(router)
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    /// App 啟動點（對應 didFinishLaunchingWithOptions）。
    ///
    /// - Parameters:
    ///   - application: 目前的 UIApplication。
    ///   - launchOptions: 啟動選項，可能為 nil。
    /// - Returns: 是否成功完成啟動流程。
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    )
        -> Bool {
        true
    }
}
