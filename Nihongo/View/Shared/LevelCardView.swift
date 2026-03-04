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
                    .padding(.trailing, -4)
                    .padding(.bottom, 12)
            }
        }
        .buttonStyle(LevelCardPressStyle(cornerRadius: cornerRadius, isSelected: isSelected))
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

/// 卡片按壓時的視覺回饋樣式。
private struct LevelCardPressStyle: ButtonStyle {
    /// 卡片圓角。
    let cornerRadius: CGFloat
    /// 是否為目前選中狀態。
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .compositingGroup()
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.pureWhite)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.accentBluePrimary.opacity(configuration.isPressed ? 0.12 : 0.0))
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(isSelected ? Color.accentBluePrimary : Color.borderPrimary, lineWidth: 1)
            )
            .shadow(
                color: Color.shadowPrimary.opacity(configuration.isPressed ? 0.0 : 1.0),
                radius: 8,
                x: 0,
                y: 4
            )
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius))
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
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
        isSelected: true,
        onSelect: { },
        onConfirm: { }
    )
    .fixedSize()
}
