import SwiftUI

/// 顯示 JLPT 等級對應的內容頁面（暫時示意）。
struct LevelDetailView: View {
    /// 由上層路由傳入的等級 ID。
    let levelId: String

    /// 用於手動返回的 Router。
    @EnvironmentObject
    private var router: AppRouter

    /// 全域 App 狀態，用於切換分頁。
    @EnvironmentObject
    private var appState: AppState

    /// 主要內容視圖。
    var body: some View {
        VStack(spacing: 16) {
            Text("Level \(levelId)")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.textPrimary)

            Text("This is a placeholder screen.")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.textSecondary)

            Button("Back to Levels") {
                router.popToRoot()
            }
            .buttonStyle(.borderedProminent)

            Button("Go to Settings") {
                router.popToRoot()
                appState.selectedTab = .settings
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
        .navigationTitle("JLPT \(levelId)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.pureWhite, for: .navigationBar)
    }
}

#Preview {
    LevelDetailView(levelId: "N5")
}
