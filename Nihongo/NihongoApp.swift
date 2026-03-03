import SwiftUI
import UIKit

@main
struct NihongoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    /// App 啟動點（對應 didFinishLaunchingWithOptions）。
    ///
    /// - Parameters:
    ///   - application: 目前的 UIApplication。
    ///   - launchOptions: 啟動選項，可能為 nil。
    /// - Returns: 是否成功完成啟動流程。
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    )
        -> Bool {
        true
    }
}
