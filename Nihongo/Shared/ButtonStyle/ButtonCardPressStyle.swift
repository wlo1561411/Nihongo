import SwiftUI

/// 卡片按壓時的視覺回饋樣式。
struct CardButtonPressStyle: ButtonStyle {
    /// 卡片圓角。
    let cornerRadius: CGFloat

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
