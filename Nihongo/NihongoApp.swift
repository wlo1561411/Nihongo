import SwiftUI
import UIKit

@main
struct NihongoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    /// 管理 app 的全域狀態（含 onboarding 流程）。
    @StateObject
    private var appState: AppState

    /// 統一管理導覽路徑的 Router。
    @StateObject
    private var router: AppRouter

    /// 建立 App 並初始化全域狀態與 Router。
    init() {
        _appState = StateObject(wrappedValue: AppState())
        _router = StateObject(wrappedValue: AppRouter())
    }

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
    var orientationLock: UIInterfaceOrientationMask = .portrait

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    )
        -> Bool {
        true
    }

    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        orientationLock
    }
}
