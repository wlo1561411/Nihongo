import FMUIKit
import UIKit

enum Design {
    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 12
        static let l: CGFloat = 16
        static let xl: CGFloat = 20
        static let xxl: CGFloat = 24
        static let xxxl: CGFloat = 32
    }

    enum Radius {
        static let s: CGFloat = 10
        static let m: CGFloat = 14
        static let l: CGFloat = 18
        static let xl: CGFloat = 24
        static let pill: CGFloat = 28
    }
}

extension UIColor {
    private static func dynamicColor(light: String, dark: String) -> UIColor {
        UIColor { traitCollection in
            let hex = traitCollection.userInterfaceStyle == .dark ? dark : light
            return UIColor(hex: hex)
        }
    }

    // MARK: - Background

    /// 主背景
    static var backgroundPrimary: UIColor {
        dynamicColor(light: "FAFAF9", dark: "0C0A09")
    }
    /// 卡片、次層底色
    static var backgroundSecondary: UIColor {
        dynamicColor(light: "F5F5F4", dark: "1C1917")
    }
    /// 導覽列、浮層
    static var backgroundElevated: UIColor {
        dynamicColor(light: "E7E5E4", dark: "292524")
    }
    /// 互動高亮
    static var backgroundHighlight: UIColor {
        dynamicColor(light: "D6D3D1", dark: "44403C")
    }

    // MARK: - Text

    /// 主要文字
    static var textPrimary: UIColor {
        dynamicColor(light: "1C1917", dark: "FAFAF9")
    }
    /// 次要文字
    static var textSecondary: UIColor {
        dynamicColor(light: "44403C", dark: "E7E5E4")
    }
    /// 輔助文字
    static var textMuted: UIColor {
        dynamicColor(light: "78716C", dark: "A8A29E")
    }
    /// 禁用文字
    static var textDisabled: UIColor {
        dynamicColor(light: "C7C9CE", dark: "5A5C61")
    }

    // MARK: - Accent

    /// 提示色
    static var accentYellow: UIColor {
        dynamicColor(light: "E7E5E4", dark: "57534E")
    }

    // MARK: - Status

    static var statusSuccess: UIColor {
        dynamicColor(light: "6B7F63", dark: "A3B8A0")
    }
    static var statusWarning: UIColor {
        dynamicColor(light: "A5845D", dark: "C8A97E")
    }
    static var statusError: UIColor {
        dynamicColor(light: "9C6B63", dark: "C49A93")
    }
}
