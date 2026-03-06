import SwiftUI

/// 管理 Onboarding 畫面的狀態與事件。
final class OnboardingViewModel {
    /// 底部列顯示的功能項目。
    /// - Important: 清單請保持精簡，避免在小螢幕上擁擠。
    let featureItems: [FeatureCardView.StateItem]

    /// 建立預設的 onboarding ViewModel。
    /// - Parameter featureItems: 自訂功能項目清單。
    init(featureItems: [FeatureCardView.StateItem] = OnboardingViewModel.defaultFeatureItems) {
        self.featureItems = featureItems
    }

    /// 預設的功能卡片資料。
    private static let defaultFeatureItems: [FeatureCardView.StateItem] = [
        FeatureCardView.StateItem(
            title: "KANJI",
            systemImageName: "book.closed",
            primaryTint: .accentPinkPrimary,
            secondaryTint: .accentPinkSecondary
        ),
        FeatureCardView.StateItem(
            title: "AUDIO",
            systemImageName: "waveform",
            primaryTint: .accentBluePrimary,
            secondaryTint: .accentBlueSecondary
        ),
        FeatureCardView.StateItem(
            title: "TESTS",
            systemImageName: "checkmark.seal",
            primaryTint: .accentGreenPrimary,
            secondaryTint: .accentGreenSecondary
        )
    ]
}
