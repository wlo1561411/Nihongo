import SwiftUI

/// App 主要分頁架構。
struct MainTabView: View {
    /// Router，用於全域導覽。
    @EnvironmentObject
    private var router: AppRouter

    /// 主要內容視圖。
    var body: some View {
        TabView(selection: $router.selectedTab) {
            tabNavigationStack(tab: .syllabary) {
                SyllabaryView()
            }
            .tabItem {
                tabLabel(
                    title: "Syllabary",
                    unselectName: "square.grid.3x3",
                    selectName: "square.grid.3x3.fill",
                    isSelected: router.selectedTab == .syllabary
                )
            }
            .tag(AppTab.syllabary)

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
                SettingsView()
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
    private func tabNavigationStack(
        tab: AppTab,
        @ViewBuilder content: () -> some View
    )
        -> some View {
        NavigationStack(path: router.binding(for: tab)) {
            content()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case let .vocabulary(viewModel):
                        VocabulariesView(viewModel: viewModel)
                    case let .vocabularyDetail(viewModel):
                        VocabularyDetailView(viewModel: viewModel)
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

#Preview {
    MainTabView()
        .environmentObject(AppRouter())
}
