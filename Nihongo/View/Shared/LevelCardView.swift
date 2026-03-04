import SwiftUI

/// 單一 JLPT 等級卡片的顯示模型。
struct LevelCardModel: Identifiable {
    /// 唯一識別值。
    let id: String
    /// 卡片主標題。
    let title: String
    /// 卡片副標題。
    let subtitle: String
    /// 右側徽章文字。
    let badgeText: String
    /// 主要行動按鈕文字。
    let actionTitle: String
}

/// 單一卡片視圖。
struct LevelCardView: View {
    /// 卡片資料模型。
    let model: LevelCardModel
    /// 是否為目前選中狀態。
    let isHighlighted: Bool
    /// 卡片圓角。
    var cornerRadius: CGFloat = 16
    /// 點擊卡片時的回呼。
    let onSelect: () -> Void

    /// 徽章大小。
    @ScaledMetric
    private var badgeSize: CGFloat = 96

    /// 主要內容視圖。
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                if isHighlighted {
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

                Text(model.actionTitle)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(isHighlighted ? Color.pureWhite : Color.textSecondary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        isHighlighted
                        ? Color.accentBluePrimary
                        : Color.backgroundPrimary,
                        in: Capsule()
                    )
                    .overlay(
                        Capsule()
                            .stroke(
                                isHighlighted ? Color.accentBluePrimary : Color.clear,
                                lineWidth: 1
                            )
                    )
            }

            Spacer()
        }
        .padding(16)
        .background(content: {
            ZStack(alignment: .bottomTrailing) {
                Color.pureWhite

                badgeView
                    .padding(.trailing, -4)
                    .padding(.bottom, 12)
            }
        })
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(isHighlighted ? Color.accentBluePrimary : Color.borderPrimary, lineWidth: 1)
        )
        .shadow(color: Color.shadowPrimary, radius: 8, x: 0, y: 4)
        .onTapGesture(perform: onSelect)
        .accessibilityElement(children: .combine)
    }

    /// 右側徽章視圖。
    private var badgeView: some View {
        ZStack {
            Circle()
                .fill(isHighlighted ? Color.accentBlueSecondary.opacity(0.4) : Color.backgroundPrimary.opacity(0.4))

            Text(model.badgeText)
                .font(.system(size: 30, weight: .black))
                .foregroundStyle(
                    isHighlighted
                        ? Color.accentBluePrimary.opacity(0.4)
                        : Color.textThirdly.opacity(0.4)
                )
        }
        .frame(width: badgeSize, height: badgeSize)
    }
}

#Preview {
    LevelCardView(
        model: LevelCardModel(
            id: "N5",
            title: "N5 - Beginner",
            subtitle: "Basic expressions and sentences",
            badgeText: "N5",
            actionTitle: "Start Quiz"
        ),
        isHighlighted: true,
        onSelect: { })
    .fixedSize()
}
