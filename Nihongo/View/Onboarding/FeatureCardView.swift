import SwiftUI

/// 用於底部列的精簡功能卡片。
struct FeatureCardView: View {
    /// 功能卡片的小型模型。
    struct CardState: Identifiable {
        /// 功能標題文字。
        let title: String
        /// 圖示的 SF Symbol 名稱。
        let systemImageName: String
        /// 卡片主色。
        let primaryTint: Color
        /// 卡片次色。
        let secondaryTint: Color

        /// diff 使用的穩定識別碼。
        var id: String {
            title
        }
    }

    let state: CardState

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(state.secondaryTint)
                    .frame(width: 44, height: 44)

                Image(systemName: state.systemImageName)
                    .renderingMode(.template)
                    .foregroundStyle(state.primaryTint)
            }

            Text(state.title)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.pureWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.shadowPrimary, radius: 10, x: 0, y: 6)
    }
}
