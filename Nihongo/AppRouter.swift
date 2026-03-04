import Combine
import Foundation
import os.log
import SwiftUI

/// 統一管理全域 NavigationStack 路徑的 Router。
@MainActor
final class AppRouter: ObservableObject {
    /// Router 內部使用的 log 介面。
    private let logger = Logger(AppRouter.self)

    /// 目前的導航路徑。
    @Published
    var path: [Route] = []

    /// 將指定的路由加入導覽堆疊。
    /// - Parameter route: 要前往的路由。
    func push(_ route: Route) {
        path.append(route)
        logger.info("導頁前往: \(route.logDescription, privacy: .public)")
    }

    /// 從導覽堆疊退回一層。
    func pop() {
        guard !path.isEmpty else {
            logger.debug("導頁堆疊為空，忽略返回")
            return
        }

        let removed = path.removeLast()
        logger.info("返回頁面: \(removed.logDescription, privacy: .public)")
    }

    /// 清空導覽堆疊，回到根視圖。
    func popToRoot() {
        guard !path.isEmpty else { return }
        path.removeAll()
        logger.info("返回根頁")
    }

    /// 以指定路由序列覆蓋導覽堆疊。
    /// - Parameter routes: 新的路由序列。
    func reset(to routes: [Route] = []) {
        path = routes
        logger.info("重設路由數量: \(routes.count, privacy: .public)")
    }
}

/// App 內的導航路由定義。
enum Route: Hashable {
    /// 依 JLPT 等級顯示詳細內容。
    case levelDetail(levelId: String)
}

extension Route {
    /// 提供給 log 使用的精簡描述字串。
    var logDescription: String {
        switch self {
        case .levelDetail(let levelId):
            return "levelDetail(\(levelId))"
        }
    }
}
