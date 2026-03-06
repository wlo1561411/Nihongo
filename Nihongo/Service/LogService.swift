import Foundation
import os

protocol LogService: Sendable {
    func log(
        category: String?,
        level: OSLogType,
        _ message: String
    )
}

extension LogService {
    func debug(
        _ message: String,
        category: String? = nil,
        target: AnyClass? = nil,
        fileID: StaticString = #fileID
    ) {
        log(category: resolveCategory(category, target: target, fileID: fileID), level: .debug, message)
    }

    func info(
        _ message: String,
        category: String? = nil,
        target: AnyClass? = nil,
        fileID: StaticString = #fileID
    ) {
        log(category: resolveCategory(category, target: target, fileID: fileID), level: .info, message)
    }

    func notice(
        _ message: String,
        category: String? = nil,
        target: AnyClass? = nil,
        fileID: StaticString = #fileID
    ) {
        log(category: resolveCategory(category, target: target, fileID: fileID), level: .default, message)
    }

    func error(
        _ message: String,
        category: String? = nil,
        target: AnyClass? = nil,
        fileID: StaticString = #fileID
    ) {
        log(category: resolveCategory(category, target: target, fileID: fileID), level: .error, message)
    }

    func fault(
        _ message: String,
        category: String? = nil,
        target: AnyClass? = nil,
        fileID: StaticString = #fileID
    ) {
        log(category: resolveCategory(category, target: target, fileID: fileID), level: .fault, message)
    }

    private func resolveCategory(_ explicit: String?, target: AnyClass?, fileID: StaticString) -> String {
        if let explicit {
            return explicit
        }

        if let target {
            return NSStringFromClass(target)
        }

        let path = String(describing: fileID)
        let fileName = path.split(separator: "/").last.map(String.init) ?? path
        return fileName.replacingOccurrences(of: ".swift", with: "")
    }
}

final class LoggerService: LogService, @unchecked Sendable {
    static let shared: LogService = LoggerService()

    private let subsystem: String
    private var loggersByCategory: [String: Logger]
    private let lock = NSLock()

    init(subsystem: String = Bundle.main.bundleIdentifier ?? "Nihongo") {
        self.subsystem = subsystem
        self.loggersByCategory = [:]
    }

    func log(
        category: String? = nil,
        level: OSLogType,
        _ message: String
    ) {
        let resolvedCategory = category ?? defaultCategory
        let logger = logger(for: resolvedCategory)
        logger.log(level: level, "\(message, privacy: .public)")
    }

    private func logger(for category: String) -> Logger {
        lock.lock()
        defer { lock.unlock() }

        if let logger = loggersByCategory[category] {
            return logger
        }

        let logger = Logger(subsystem: subsystem, category: category)
        loggersByCategory[category] = logger
        return logger
    }

    private let defaultCategory = "App"
}
