import SwiftUI

/// App 主要分頁架構。
struct MainTabView: View {
    /// 目前選中的分頁。
    @State private var selection: Tab

    /// 建立主要分頁結構。
    /// - Parameter selection: 預設選中分頁。
    init(selection: Tab = .learn) {
        _selection = State(initialValue: selection)
        setupTabBarAppearance()
    }

    /// 主要內容視圖。
    var body: some View {
        TabView(selection: $selection) {
            ChooseLevelView()
                .tabItem {
                    Label("Learn", systemImage: "book")
                }
                .tag(Tab.learn)

            ChooseLevelView()
                .tabItem {
                    Label("Quizzes", systemImage: "questionmark.circle")
                }
                .tag(Tab.quizzes)

            SettingsPlaceholderView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(Tab.settings)
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
}

/// 主要分頁識別。
enum Tab: Hashable {
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
}
