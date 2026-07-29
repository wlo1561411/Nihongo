import SwiftUI
import UIKit

extension Color {
    static let backgroundPrimary = Color.dynamic(
        light: .init(hex: "F6F6F8"),
        dark: .init(hex: "F6F6F8")
    )

    static let backgroundSecondary = Color.dynamic(
        light: .init(hex: "F8FAFC"),
        dark: .init(hex: "F8FAFC")
    )

    static let textPrimary = Color.dynamic(
        light: .init(hex: "0F172A"),
        dark: .init(hex: "0F172A")
    )

    static let textSecondary = Color.dynamic(
        light: .init(hex: "475569"),
        dark: .init(hex: "475569")
    )

    static let textThirdly = Color.dynamic(
        light: .init(hex: "94A3B8"),
        dark: .init(hex: "94A3B8")
    )

    static let shadowPrimary = Color.dynamic(
        light: .init(hex: "000000").withAlphaComponent(0.08),
        dark: .init(hex: "000000").withAlphaComponent(0.08)
    )

    static let borderPrimary = Color.dynamic(
        light: .init(hex: "E2E8F0"),
        dark: .init(hex: "E2E8F0")
    )

    static let accentBluePrimary = Color.dynamic(
        light: .init(hex: "3B2BEE"),
        dark: .init(hex: "3B2BEE")
    )

    static let accentBlueSecondary = Color.dynamic(
        light: .init(hex: "DBEAFE"),
        dark: .init(hex: "DBEAFE")
    )

    static let accentPinkPrimary = Color.dynamic(
        light: .init(hex: "F472B6"),
        dark: .init(hex: "F472B6")
    )

    static let accentPinkSecondary = Color.dynamic(
        light: .init(hex: "FCE7F3"),
        dark: .init(hex: "FCE7F3")
    )

    static let accentGreenPrimary = Color.dynamic(
        light: .init(hex: "16A34A"),
        dark: .init(hex: "16A34A")
    )

    static let accentGreenSecondary = Color.dynamic(
        light: .init(hex: "DCFCE7"),
        dark: .init(hex: "DCFCE7")
    )

    static let accentTealPrimary = Color.dynamic(
        light: .init(hex: "0D9488"),
        dark: .init(hex: "0D9488")
    )

    static let accentTealSecondary = Color.dynamic(
        light: .init(hex: "CCFBF1"),
        dark: .init(hex: "CCFBF1")
    )

    static let accentPurplePrimary = Color.dynamic(
        light: .init(hex: "A855F7"),
        dark: .init(hex: "A855F7")
    )

    static let accentPurpleSecondary = Color.dynamic(
        light: .init(hex: "F3E8FF"),
        dark: .init(hex: "F3E8FF")
    )

    static let accentOrangePrimary = Color.dynamic(
        light: .init(hex: "F97316"),
        dark: .init(hex: "F97316")
    )

    static let accentOrangeSecondary = Color.dynamic(
        light: .init(hex: "FFEDD5"),
        dark: .init(hex: "FFEDD5")
    )

    static let accentRedPrimary = Color.dynamic(
        light: .init(hex: "EF4444"),
        dark: .init(hex: "EF4444")
    )

    static let accentRedSecondary = Color.dynamic(
        light: .init(hex: "FEE2E2"),
        dark: .init(hex: "FEE2E2")
    )

    static let accentYellowPrimary = Color.dynamic(
        light: .init(hex: "FACC15"),
        dark: .init(hex: "FACC15")
    )

    static let accentYellowSecondary = Color.dynamic(
        light: .init(hex: "FEF9C3"),
        dark: .init(hex: "FEF9C3")
    )

    static let pureWhite = Color(uiColor: .init(hex: "FFFFFF"))
}

extension Color {
    /// 建立依照色彩模式切換的動態色。
    static func dynamic(light: UIColor, dark: UIColor) -> Color {
        Color(uiColor: .dynamic(light: light, dark: dark))
    }
}

extension UIColor {
    /// 建立依照色彩模式切換的動態色。
    static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        UIColor { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                dark
            default:
                light
            }
        }
    }

    convenience init(hex: String?) {
        guard let hex
        else {
            self.init(white: 0.0, alpha: 0.0)
            return
        }

        let r, g, b, a: CGFloat
        var hexString = hex

        if hexString.hasPrefix("#") {
            hexString = hexString.replacingOccurrences(of: "#", with: "")
        }

        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0

        switch hexString.count {
        // rgb（alpha = 1.0）
        case 6:
            guard scanner.scanHexInt64(&hexNumber)
            else {
                self.init(white: 0.0, alpha: 0.0)
                return
            }

            r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000FF) / 255
            a = 1.0
            self.init(red: r, green: g, blue: b, alpha: a)

        // rgba
        case 8:
            guard scanner.scanHexInt64(&hexNumber)
            else {
                self.init(white: 0.0, alpha: 0.0)
                return
            }

            r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000FF) / 255
            self.init(red: r, green: g, blue: b, alpha: a)

        default:
            self.init(white: 0.0, alpha: 0.0)
            return
        }
    }
}
