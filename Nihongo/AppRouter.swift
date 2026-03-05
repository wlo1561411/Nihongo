import Combine
import Foundation
import os.log
import SwiftUI

/// 統一管理各分頁 NavigationStack 路徑的 Router。
@MainActor
final class AppRouter: ObservableObject {
    /// Router 內部使用的 log 介面。
    private let logger = Logger(AppRouter.self)

    /// 由 App 注入的全域狀態。
    private let appState: AppState

    /// 以分頁為單位管理的導航路徑。
    @Published
    private var pathsByTab: [AppTab: [Route]] = [:]

    /// 建立 Router 並注入全域狀態。
    /// - Important: 請於 App 啟動時建立，確保導頁能取得正確分頁。
    /// - Parameter appState: 全域 App 狀態。
    init(appState: AppState) {
        self.appState = appState
    }

    /// 取得目前選取分頁。
    private var currentTab: AppTab {
        appState.selectedTab
    }

    /// 取得指定分頁的導覽路徑。
    /// - Parameter tab: 目標分頁。
    /// - Returns: 目前的路由序列。
    func path(for tab: AppTab) -> [Route] {
        pathsByTab[tab, default: []]
    }

    /// 綁定指定分頁的導覽路徑，提供給 NavigationStack 使用。
    /// - Parameter tab: 目標分頁。
    /// - Returns: 對應分頁的路徑綁定。
    func binding(for tab: AppTab) -> Binding<[Route]> {
        Binding(
            get: { self.pathsByTab[tab, default: []] },
            set: { self.pathsByTab[tab] = $0 }
        )
    }

    /// 將指定的路由加入目前分頁的導覽堆疊。
    /// - Parameter route: 要前往的路由。
    func push(_ route: Route) {
        push(route, in: currentTab)
    }

    /// 將指定的路由加入特定分頁的導覽堆疊。
    /// - Parameters:
    ///   - route: 要前往的路由。
    ///   - tab: 目標分頁。
    func push(_ route: Route, in tab: AppTab) {
        var path = pathsByTab[tab, default: []]
        path.append(route)
        pathsByTab[tab] = path
        logger.info("導頁前往: \(route.logDescription), tab: \(tab.logDescription)")
    }

    /// 從目前分頁的導覽堆疊退回一層。
    func pop() {
        pop(in: currentTab)
    }

    /// 從指定分頁的導覽堆疊退回一層。
    /// - Parameter tab: 目標分頁。
    func pop(in tab: AppTab) {
        guard var path = pathsByTab[tab], !path.isEmpty else {
            logger.debug("導頁堆疊為空，忽略返回, tab: \(tab.logDescription)")
            return
        }

        let removed = path.removeLast()
        pathsByTab[tab] = path
        logger.info("返回頁面: \(removed.logDescription), tab: \(tab.logDescription)")
    }

    /// 清空目前分頁的導覽堆疊，回到根視圖。
    func popToRoot() {
        popToRoot(in: currentTab)
    }

    /// 清空指定分頁的導覽堆疊，回到根視圖。
    /// - Parameter tab: 目標分頁。
    func popToRoot(in tab: AppTab) {
        guard let path = pathsByTab[tab], !path.isEmpty else { return }
        pathsByTab[tab] = []
        logger.info("返回根頁, tab: \(tab.logDescription)")
    }

    /// 以指定路由序列覆蓋目前分頁的導覽堆疊。
    /// - Parameter routes: 新的路由序列。
    func reset(to routes: [Route] = []) {
        reset(to: routes, in: currentTab)
    }

    /// 以指定路由序列覆蓋指定分頁的導覽堆疊。
    /// - Parameters:
    ///   - routes: 新的路由序列。
    ///   - tab: 目標分頁。
    func reset(to routes: [Route] = [], in tab: AppTab) {
        pathsByTab[tab] = routes
        logger.info("重設路由數量: \(routes.count), tab: \(tab.logDescription)")
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
extension AppTab {
    /// 提供給 log 使用的精簡描述字串。
    var logDescription: String {
        "\(self)"
    }
}

