import SwiftUI

/// App 主要分頁架構。
struct MainTabView: View {
    /// Router，用於全域導覽。
    @EnvironmentObject
    private var router: AppRouter

    /// 主要內容視圖。
    var body: some View {
        TabView(selection: $router.selectedTab) {
            tabNavigationStack(tab: .learn) {
                LearnView()
            }
            .tabItem {
                tabLabel(
                    title: "Learn",
                    unselectName: "book",
                    selectName: "book.fill",
                    isSelected: router.selectedTab == .learn
                )
            }
            .tag(AppTab.learn)

            tabNavigationStack(tab: .quizzes) {
                QuizView()
            }
            .tabItem {
                tabLabel(
                    title: "Quizzes",
                    unselectName: "questionmark.circle",
                    selectName: "questionmark.circle.fill",
                    isSelected: router.selectedTab == .quizzes
                )
            }
            .tag(AppTab.quizzes)

            tabNavigationStack(tab: .settings) {
                SettingsPlaceholderView()
            }
            .tabItem {
                tabLabel(
                    title: "Settings",
                    unselectName: "gearshape",
                    selectName: "gearshape.fill",
                    isSelected: router.selectedTab == .settings
                )
            }
            .tag(AppTab.settings)
        }
    }

    /// 建立指定分頁的 NavigationStack，並綁定對應路由。
    /// - Parameters:
    ///   - tab: 目標分頁。
    ///   - content: 分頁內容。
    /// - Returns: 包含導覽堆疊的分頁內容。
    private func tabNavigationStack(
        tab: AppTab,
        @ViewBuilder content: () -> some View
    )
        -> some View {
        NavigationStack(path: router.binding(for: tab)) {
            content()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .vocabulary(let level):
                        VocabularyView(viewModel: .init(
                            level: level,
                            store: JLPTVocabularyStore.shared,
                            favoritesStore: UserDefaultsFavoritesStore.shared))
                    }
                }
        }
    }

    private func tabLabel(title: String, unselectName: String, selectName: String, isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            Image(uiImage: createTabIcon(unselectName: unselectName, selectName: selectName, isSelected: isSelected))
            Text(title)
        }
    }

    private func createTabIcon(unselectName: String, selectName: String, isSelected: Bool) -> UIImage {
        let color = isSelected ? Color.accentBluePrimary : Color.textSecondary
        let name = isSelected ? selectName : unselectName

        return UIImage(systemName: name)?
            // ignore TabView.tint for liquid glass
            .withTintColor(.init(color), renderingMode: .alwaysOriginal) ?? UIImage()
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
}
