import SwiftUI

/// 顯示 onboarding 主視覺版面的畫面。
/// - Note: 此畫面僅負責呈現 UI，不包含任何 business logic。
struct OnboardingView: View {
    /// 由上層注入的全域狀態，用於完成 onboarding 後切換到主畫面。
    @EnvironmentObject
    private var appState: AppState

    /// 提供 onboarding 的狀態與。
    @State
    private var viewModel = OnboardingViewModel()

    /// 隨 Dynamic Type 調整主視覺圖片尺寸。
    /// - Note: 用於在無障礙字體大小下維持視覺平衡。
    @ScaledMetric
    private var heroSize: CGFloat = 300

    /// 組成 onboarding 的主視覺內容。
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 24) {
                heroPlaceholder

                titleSection

                startButton

                featureRow
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 32)
        }
    }

    /// 主視覺圖片區塊的圓角圖片。
    private var heroPlaceholder: some View {
        Image("onboarding")
            .resizable()
            .scaledToFit()
            .frame(width: heroSize, height: heroSize)
            .shadow(color: Color.shadowPrimary, radius: 18, x: 0, y: 10)
    }

    /// 主標與副標區塊。
    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("Japanese Vocabulary")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(Color.textPrimary)

            Text("Step by Step")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(Color.accentBluePrimary)

            Text("All of \(JLPTLevel.highest.displayName) to \(JLPTLevel.lowest.displayName), in Japanese!")
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
        }
    }

    /// 主要 CTA 按鈕。
    private var startButton: some View {
        Button {
            appState.isFirstLaunch = false
        } label: {
            Text("Start Learning")
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundStyle(Color.pureWhite)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.accentBluePrimary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .shadow(color: Color.shadowPrimary, radius: 12, x: 0, y: 6)
    }

    /// 顯示功能卡片的列。
    private var featureRow: some View {
        HStack(spacing: 16) {
            ForEach(viewModel.featureItems) { item in
                FeatureCardView(item: item)
            }
        }
    }
}

/// 用於底部列的精簡功能卡片。
/// - Important: 請使用短標題以避免截斷。
struct FeatureCardView: View {
    /// 功能卡片的小型模型。
    struct StateItem: Identifiable {
        /// 功能標題文字。
        let title: String

        /// 供 diff 使用的穩定識別碼。
        var id: String {
            title
        }

        /// 圖示的 SF Symbol 名稱。
        let systemImageName: String

        /// 卡片主色與次色。
        let primaryTint: Color
        let secondaryTint: Color
    }

    /// 驅動卡片內容的模型。
    let item: StateItem

    /// 建立單一卡片內容。
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(item.secondaryTint)
                    .frame(width: 44, height: 44)

                Image(systemName: item.systemImageName)
                    .renderingMode(.template)
                    .foregroundStyle(item.primaryTint)
            }

            Text(item.title)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.pureWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.shadowPrimary, radius: 10, x: 0, y: 6)
        .accessibilityLabel(item.title)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
