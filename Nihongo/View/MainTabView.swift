import SwiftUI

/// App 主要分頁架構。
struct MainTabView: View {
    /// Router，用於全域導覽。
    @EnvironmentObject
    private var router: AppRouter

    /// 全域 App 狀態，用於分頁切換。
    @EnvironmentObject
    private var appState: AppState

    /// 建立主要分頁結構。
    init() {
        setupNavigationBarAppearance()
        setupTabBarAppearance()
    }

    /// 主要內容視圖。
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $appState.selectedTab) {
                ChooseLevelView()
                    .tabItem {
                        Label("Learn", systemImage: "book")
                    }
                    .tag(AppTab.learn)

                SettingsPlaceholderView()
                    .tabItem {
                        Label("Quizzes", systemImage: "questionmark.circle")
                    }
                    .tag(AppTab.quizzes)

                SettingsPlaceholderView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(AppTab.settings)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .levelDetail(let levelId):
                    LevelDetailView(levelId: levelId)
                }
            }
        }
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()

        appearance.stackedLayoutAppearance.selected.iconColor = .init(.accentBluePrimary)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(.accentBluePrimary)
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = .init(.textSecondary)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(.textSecondary)
        ]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    /// 設定 Navigation Bar 外觀。
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        appearance.backgroundColor = UIColor(Color.backgroundPrimary)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.textPrimary),
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.textPrimary),
            .font: UIFont.systemFont(ofSize: 32, weight: .bold)
        ]

        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = UIColor(Color.accentBluePrimary)
    }
}

/// 主要分頁識別。
enum AppTab: Hashable {
    /// 學習頁。
    case learn
    /// 測驗頁。
    case quizzes
    /// 設定頁。
    case settings
}

/// 設定頁暫時佔位畫面。
private struct SettingsPlaceholderView: View {
    /// 主要內容視圖。
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "gearshape")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(Color.textSecondary)

            Text("Settings")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.textPrimary)

            Text("Coming soon")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppRouter())
        .environmentObject(AppState())
}
