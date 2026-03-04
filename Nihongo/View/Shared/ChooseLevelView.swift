import SwiftUI

/// JLPT 等級選擇入口畫面。
struct ChooseLevelView: View {
    /// 預設顯示的等級卡片清單。
    private let levels: [LevelCardModel] = [
        LevelCardModel(
            id: "N5",
            title: "N5 - Beginner",
            subtitle: "Basic expressions and sentences",
            badgeText: "N5",
            actionTitle: "Start Learning"
        ),
        LevelCardModel(
            id: "N4",
            title: "N4 - Elementary",
            subtitle: "Everyday topics and basic kanji",
            badgeText: "N4",
            actionTitle: "Start Learning"
        ),
        LevelCardModel(
            id: "N3",
            title: "N3 - Intermediate",
            subtitle: "Daily life situations and reading",
            badgeText: "N3",
            actionTitle: "Start Learning"
        ),
        LevelCardModel(
            id: "N2",
            title: "N2 - Pre-Advanced",
            subtitle: "Business and specialized topics",
            badgeText: "N2",
            actionTitle: "Start Learning"
        ),
        LevelCardModel(
            id: "N1",
            title: "N1 - Advanced",
            subtitle: "Complex abstract concepts",
            badgeText: "N1",
            actionTitle: "Start Learning"
        )
    ]

    /// 目前選取的等級 ID。
    @State
    private var selectedLevelID = "N5"

    /// Router，用於導頁。
    @EnvironmentObject
    private var router: AppRouter

    /// 主要內容視圖。
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                    .padding(.top, 10)
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentBluePrimary)
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(levels) { level in
                            let isHighlighted = level.id == selectedLevelID
                            LevelCardView(
                                model: level,
                                isHighlighted: isHighlighted,
                                onSelect: { handleLevelAction(level) }
                            )
                        }
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal, 24)
                }
                .scrollIndicators(.never)
            }
        }
        .overlay(alignment: .top) {
            Color.accentBluePrimary
                .ignoresSafeArea(edges: .top)
                // This will constrain the overlay to only go above the top safe area and not under.
                .frame(height: 0)
        }
    }

    /// 頁首標題區塊。
    private var header: some View {
        VStack(spacing: 8) {
            Text("Choose Your Level")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.pureWhite)

            Text("Select a JLPT level.")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.pureWhite)
                .multilineTextAlignment(.center)
        }
    }

    /// 處理等級按鈕點擊。
    /// - Important: 目前先導到示意頁，後續可替換為真正的學習流程。
    /// - Parameter level: 使用者選取的等級。
    private func handleLevelAction(_ level: LevelCardModel) {
        selectedLevelID = level.id
        router.push(.levelDetail(levelId: level.id))
    }
}

#Preview {
    ChooseLevelView()
        .environmentObject(AppRouter())
}
