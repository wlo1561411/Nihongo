import SwiftUI

struct PrimaryButtonPressStyle: ButtonStyle {
    let isSelected: Bool

    let textFontSize: CGFloat
    var selectedTextColor = Color.surfacePrimary
    var unselectedTextColor = Color.textSecondary

    var selectedBackgroundColor = Color.accentBluePrimary
    var unselectedBackgroundColor = Color.backgroundPrimary

    var borderWidth: CGFloat = 0
    var selectedBorderColor = Color.accentBluePrimary
    var unselectedBorderColor = Color.clear

    var shadowColor = Color.shadowPrimary

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: textFontSize, weight: .semibold))
            .foregroundStyle(isSelected ? selectedTextColor : unselectedTextColor)
            .background(
                isSelected
                    ? selectedBackgroundColor
                    : unselectedBackgroundColor,
                in: Capsule()
            )
            .overlay(
                Capsule()
                    .stroke(
                        isSelected ? selectedBorderColor : unselectedBorderColor,
                        lineWidth: borderWidth
                    )
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .shadow(
                color: shadowColor,
                radius: 8,
                x: 0,
                y: 4
            )
    }
}
