import UIKit
import SwiftUI

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
