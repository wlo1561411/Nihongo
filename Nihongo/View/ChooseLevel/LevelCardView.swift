import SwiftUI

/// 單一卡片視圖。
struct LevelCardView: View {
    /// 單一 JLPT 等級卡片的顯示模型。
    struct StateItem: Identifiable {
        /// 唯一識別值。
        let id: JLPTLevel
        /// 卡片主標題。
        let title: String
        /// 卡片副標題。
        let subtitle: String
        /// 右側徽章文字。
        let badgeText: String
        /// 主要行動按鈕文字。
        var actionTitle: String
    }

    /// 卡片資料模型。
    let model: LevelCardView.StateItem
    /// 是否為目前選中狀態。
    let isSelected: Bool
    /// 卡片圓角。
    var cornerRadius: CGFloat = 16
    /// 點擊卡片時的回呼。
    let onSelect: () -> Void
    /// 點擊按鈕時的回呼。
    let onConfirm: () -> Void

    /// 徽章大小。
    @ScaledMetric
    private var badgeSize: CGFloat = 96

    /// 主要內容視圖。
    var body: some View {
        Button(action: onSelect) {
            ZStack(alignment: .bottomTrailing) {
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        if isSelected {
                            Text("LEVEL")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(Color.accentBluePrimary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.accentBlueSecondary, in: Capsule())
                        }

                        Text(model.title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color.textPrimary)

                        Text(model.subtitle)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.textSecondary)

                        Spacer(minLength: 12)

                        Button(action: onConfirm) {
                            Text(model.actionTitle)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(isSelected ? Color.pureWhite : Color.textSecondary)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(
                                    isSelected
                                        ? Color.accentBluePrimary
                                        : Color.backgroundPrimary,
                                    in: Capsule()
                                )
                                .overlay(
                                    Capsule()
                                        .stroke(
                                            isSelected ? Color.accentBluePrimary : Color.clear,
                                            lineWidth: 1
                                        )
                                )
                        }
                    }

                    Spacer()
                }

                badgeView
                    .padding(.trailing, -20)
                    .padding(.bottom, -20)
            }
        }
        .buttonStyle(CardButtonPressStyle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(isSelected ? Color.accentBluePrimary : Color.borderPrimary, lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
    }

    /// 右側徽章視圖。
    private var badgeView: some View {
        ZStack {
            Circle()
                .fill(isSelected ? Color.accentBlueSecondary.opacity(0.4) : Color.backgroundPrimary.opacity(0.4))

            Text(model.badgeText)
                .font(.system(size: 30, weight: .black))
                .foregroundStyle(
                    isSelected
                        ? Color.accentBluePrimary.opacity(0.4)
                        : Color.textThirdly.opacity(0.4)
                )
        }
        .frame(width: badgeSize, height: badgeSize)
    }
}

#Preview {
    ZStack {
        Color.white
            .ignoresSafeArea()

        LevelCardView(
            model: LevelCardView.StateItem(
                id: .n5,
                title: "\(JLPTLevel.n5.displayName) - Beginner",
                subtitle: "Basic expressions and sentences",
                badgeText: JLPTLevel.n5.displayName,
                actionTitle: "Start Quiz"
            ),
            isSelected: true,
            onSelect: { },
            onConfirm: { }
        )
        .fixedSize()
    }
}
