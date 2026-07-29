import Combine
import Foundation
import SwiftUI

/// 統一管理各分頁 NavigationStack 路徑的 Router。
@MainActor
final class AppRouter: ObservableObject {
    /// Router 內部使用的 log 介面。
    private let logService: LogService

    /// 目前選中的分頁。
    /// - Note: 分頁狀態僅於記憶體中維持，不做持久化。
    @Published
    var selectedTab: AppTab = .learn

    /// 以分頁為單位管理的導航路徑。
    @Published
    private var pathsByTab: [AppTab: [Route]] = [:]

    /// 建立 Router。
    /// - Important: 請於 App 啟動時建立，確保導頁能取得正確分頁。
    init(logService: LogService = LoggerService.shared) {
        self.logService = logService
    }

    /// 取得指定分頁的導覽路徑。
    func path(for tab: AppTab) -> [Route] {
        pathsByTab[tab, default: []]
    }

    /// 綁定指定分頁的導覽路徑，提供給 NavigationStack 使用。
    func binding(for tab: AppTab) -> Binding<[Route]> {
        Binding(
            get: { self.pathsByTab[tab, default: []] },
            set: { self.pathsByTab[tab] = $0 }
        )
    }

    /// 將指定的路由加入特定分頁的導覽堆疊。
    func push(_ route: Route, in tab: AppTab? = nil) {
        let tab = tab ?? selectedTab
        var path = pathsByTab[tab, default: []]
        path.append(route)
        pathsByTab[tab] = path
        logService.info("導頁前往: \(route.logDescription), tab: \(tab.logDescription)")
    }

    /// 從指定分頁的導覽堆疊退回一層。
    func pop(in tab: AppTab) {
        guard var path = pathsByTab[tab], !path.isEmpty else {
            logService.debug("導頁堆疊為空，忽略返回, tab: \(tab.logDescription)")
            return
        }

        let removed = path.removeLast()
        pathsByTab[tab] = path
        logService.info("返回頁面: \(removed.logDescription), tab: \(tab.logDescription)")
    }

    /// 清空指定分頁的導覽堆疊，回到根視圖。
    func popToRoot(in tab: AppTab? = nil) {
        let tab = tab ?? selectedTab
        guard let path = pathsByTab[tab], !path.isEmpty else {
            return
        }
        pathsByTab[tab] = []
        logService.info("返回根頁, tab: \(tab.logDescription)")
    }

    /// 以指定路由序列覆蓋指定分頁的導覽堆疊。
    func reset(to routes: [Route] = [], in tab: AppTab? = nil) {
        let tab = tab ?? selectedTab
        pathsByTab[tab] = routes
        logService.info("重設路由數量: \(routes.count), tab: \(tab.logDescription)")
    }
}

/// App 內的導航路由定義。
@MainActor
enum Route: Hashable {
    /// 依 JLPT 等級顯示詳細內容。
    case vocabulary(viewModel: VocabulariesViewModel)
    /// 顯示單一詞彙詳細內容。
    case vocabularyDetail(viewModel: VocabularyDetailViewModel)

    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case let (.vocabulary(lhsViewModel), .vocabulary(rhsViewModel)):
            lhsViewModel.level == rhsViewModel.level
        case let (.vocabularyDetail(lhsViewModel), .vocabularyDetail(rhsViewModel)):
            lhsViewModel.vocabulary.word == rhsViewModel.vocabulary.word
        default:
            false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .vocabulary(let viewModel):
            hasher.combine("vocabulary")
            hasher.combine(viewModel.level)
        case .vocabularyDetail(let viewModel):
            hasher.combine("vocabularyDetail")
            hasher.combine(viewModel.vocabulary.word)
        }
    }
}

extension Route {
    /// 提供給 log 使用的精簡描述字串。
    var logDescription: String {
        switch self {
        case .vocabulary(let viewModel):
            "vocabulary(\(viewModel.level.displayName))"
        case .vocabularyDetail(viewModel: let viewModel):
            "vocabularyDetail(\(viewModel.vocabulary.word))"
        }
    }
}

extension AppTab {
    /// 提供給 log 使用的精簡描述字串。
    var logDescription: String {
        "\(self)"
    }
}
