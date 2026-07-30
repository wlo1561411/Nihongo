import SwiftUI

/// 顯示 onboarding 主視覺版面的畫面。
/// - Note: 此畫面僅負責呈現 UI，不包含任何 business logic。
struct OnboardingView: View {
    /// 由上層注入的全域狀態，用於完成 onboarding 後切換到主畫面。
    @EnvironmentObject
    private var appState: AppState

    /// 提供 onboarding 的狀態與。
    private let viewModel = OnboardingViewModel()

    /// 隨 Dynamic Type 調整主視覺圖片尺寸。
    /// - Note: 用於在無障礙字體大小下維持視覺平衡。
    @ScaledMetric
    private var heroSize: CGFloat = 300

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
                .foregroundStyle(Color.surfacePrimary)
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
            ForEach(viewModel.featureStates) { item in
                FeatureCardView(state: item)
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
