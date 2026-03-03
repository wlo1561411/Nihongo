import Foundation
import os.log

extension Logger {
    init(_ target: AnyObject.Type) {
        self.init(subsystem: Bundle.main.bundleIdentifier ?? "Nihongo", category: NSStringFromClass(target))
    }
}
