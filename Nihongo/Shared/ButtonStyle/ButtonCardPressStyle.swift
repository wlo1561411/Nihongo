import SwiftUI

/// 卡片按壓時的視覺回饋樣式。
struct CardButtonPressStyle: ButtonStyle {
    @ScaledMetric
    var cornerRadius: CGFloat = 18
    @ScaledMetric
    var padding: CGFloat = 16

    var borderColor: Color = .clear
    var borderWidth: CGFloat = 0

    func makeBody(configuration: Configuration) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius)

        configuration.label
            .padding(padding)
            .background(Color.pureWhite)
            .clipShape(shape)
            .overlay {
                shape.fill(Color.accentBluePrimary.opacity(configuration.isPressed ? 0.12 : 0.0))
            }
            .overlay {
                shape.stroke(borderColor, lineWidth: borderWidth)
            }
            .shadow(
                color: Color.shadowPrimary.opacity(configuration.isPressed ? 0.0 : 1.0),
                radius: 8,
                x: 0,
                y: 4
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
