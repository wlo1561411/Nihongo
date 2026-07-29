import SwiftUI

struct IconButtonPressStyle: ButtonStyle {
    /// 按下時縮放比例。
    private let pressedScale: CGFloat = 0.9
    /// 按下時透明度。
    private let pressedOpacity = 0.65

    /// 建立按鈕樣式。
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .opacity(configuration.isPressed ? pressedOpacity : 1)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}
