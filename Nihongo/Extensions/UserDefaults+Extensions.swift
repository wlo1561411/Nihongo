import FMFoundation
import Foundation

extension UserDefaults {
    @UserDefault("isAutoSpeak")
    static var isAutoSpeak: Bool = false

    @UserDefault("isDarkModeEnabled")
    static var isDarkModeEnabled: Bool = false
}
