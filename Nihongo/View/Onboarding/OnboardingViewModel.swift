import SwiftUI

/// 管理 Onboarding 畫面的狀態與事件。
final class OnboardingViewModel {
    /// 底部列顯示的功能項目。
    /// - Important: 清單請保持精簡，避免在小螢幕上擁擠。
    let featureStates: [FeatureCardView.CardState]

    /// 建立 onboarding ViewModel。
    init(featureStates: [FeatureCardView.CardState] = OnboardingViewModel.defaultFeatureStates) {
        self.featureStates = featureStates
    }

    /// 預設的功能卡片資料。
    private static let defaultFeatureStates: [FeatureCardView.CardState] = [
        FeatureCardView.CardState(
            title: "KANJI",
            systemImageName: "book.closed",
            primaryTint: .accentPinkPrimary,
            secondaryTint: .accentPinkSecondary
        ),
        FeatureCardView.CardState(
            title: "AUDIO",
            systemImageName: "waveform",
            primaryTint: .accentBluePrimary,
            secondaryTint: .accentBlueSecondary
        ),
        FeatureCardView.CardState(
            title: "TESTS",
            systemImageName: "checkmark.seal",
            primaryTint: .accentGreenPrimary,
            secondaryTint: .accentGreenSecondary
        )
    ]
}
