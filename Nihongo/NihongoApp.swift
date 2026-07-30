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

        setupNavigationBarAppearance()
        setupTabBarAppearance()
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

    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.surfacePrimary)
        appearance.shadowColor = .clear
        appearance.shadowImage = .init()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            .foregroundColor: UIColor(Color.textPrimary),
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        let normalAttributed: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(Color.textSecondary),
            .font: UIFont.systemFont(ofSize: 10, weight: .semibold),
        ]
        let selectedAttributed: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(Color.accentBluePrimary),
            .font: UIFont.systemFont(ofSize: 10, weight: .bold),
        ]

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributed
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalAttributed
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = normalAttributed

        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributed
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedAttributed
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedAttributed

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
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
