import Foundation

extension SettingViewController {
    final class ViewModel {
        var isAutoSpeak: Bool {
            UserDefaults.isAutoSpeak
        }

        var isDarkModeEnabled: Bool {
            UserDefaults.isDarkModeEnabled
        }

        func setAutoSpeak(_ isEnabled: Bool) {
            UserDefaults.isAutoSpeak = isEnabled
        }

        func setDarkModeEnabled(_ isEnabled: Bool) {
            UserDefaults.isDarkModeEnabled = isEnabled
        }
    }
}
