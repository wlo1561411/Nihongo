import Foundation

/// 管理單字收藏狀態的存取與持久化。
protocol FavoritesStore {
    /// 讀取目前已收藏的 Key 集合。
    /// - Returns: 收藏 Key 集合。
    func loadFavorites() async -> Set<String>

    func isFavorited(_ key: String) async -> Bool

    /// 新增單一收藏 Key。
    func addFavorite(_ key: String) async

    /// 移除單一收藏 Key。
    func removeFavorite(_ key: String) async
}

extension FavoritesStore {
    func execute(
        key: String,
        isFavorite: Bool
    ) async {
        if isFavorite {
            await addFavorite(key)
        } else {
            await removeFavorite(key)
        }
    }
}

/// 使用 `UserDefaults` 儲存收藏狀態。
actor UserDefaultsFavoritesStore: FavoritesStore {
    static let shared = UserDefaultsFavoritesStore()

    private var keys: Set<String> = []

    /// `UserDefaults` 實例。
    private let userDefaults: UserDefaults

    /// 收藏儲存的 Key。
    private let storageKey: String

    /// Log 用途的 logger。
    private let logService: LogService

    /// 建立 `UserDefaults` 收藏儲存器。
    private init(
        userDefaults: UserDefaults = .standard,
        storageKey: String = "favorites.vocabulary",
        logService: LogService = LoggerService.shared
    ) {
        self.userDefaults = userDefaults
        self.storageKey = storageKey
        self.logService = logService
    }

    func loadFavorites() async -> Set<String> {
        let favorites = Set(userDefaults.stringArray(forKey: storageKey) ?? [])
        keys = favorites
        logService.debug("已讀取收藏狀態。數量：\(favorites.count)")
        return favorites
    }

    func isFavorited(_ key: String) async -> Bool {
        keys.contains(key)
    }

    func addFavorite(_ key: String) async {
        keys.insert(key)
        userDefaults.set(Array(keys), forKey: storageKey)
        logService.debug("已新增收藏狀態。數量：\(keys.count)")
    }

    func removeFavorite(_ key: String) async {
        keys.remove(key)
        userDefaults.set(Array(keys), forKey: storageKey)
        logService.debug("已移除收藏狀態。數量：\(keys.count)")
    }
}
