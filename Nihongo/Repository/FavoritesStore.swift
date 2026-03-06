import Foundation

/// 管理單字收藏狀態的存取與持久化。
protocol FavoritesStore {
    /// 讀取目前已收藏的 Key 集合。
    /// - Returns: 收藏 Key 集合。
    func loadFavorites() -> Set<String>

    /// 儲存完整的收藏 Key 集合。
    /// - Parameter favorites: 要寫入的收藏集合。
    func saveFavorites(_ favorites: Set<String>)
}

/// 使用 `UserDefaults` 儲存收藏狀態。
final class UserDefaultsFavoritesStore: FavoritesStore {
    static let shared = UserDefaultsFavoritesStore()

    /// `UserDefaults` 實例。
    private let userDefaults: UserDefaults

    /// 收藏儲存的 Key。
    private let storageKey: String

    /// Log 用途的 logger。
    /// - Note: 只用於輸出可觀測訊息，避免落入敏感資訊。
    private let logService: LogService

    /// 建立 `UserDefaults` 收藏儲存器。
    /// - Parameters:
    ///   - userDefaults: 注入的 `UserDefaults`。
    ///   - storageKey: 收藏寫入用的 Key。
    private init(
        userDefaults: UserDefaults = .standard,
        storageKey: String = "favorites.vocabulary",
        logService: LogService = LoggerService.shared
    ) {
        self.userDefaults = userDefaults
        self.storageKey = storageKey
        self.logService = logService
    }

    /// 讀取目前已收藏的 Key 集合。
    /// - Returns: 收藏 Key 集合。
    func loadFavorites() -> Set<String> {
        let favorites = Set(userDefaults.stringArray(forKey: storageKey) ?? [])
        logService.debug("已讀取收藏狀態。數量：\(favorites.count)")
        return favorites
    }

    /// 儲存完整的收藏 Key 集合。
    /// - Parameter favorites: 要寫入的收藏集合。
    func saveFavorites(_ favorites: Set<String>) {
        userDefaults.set(Array(favorites), forKey: storageKey)
        logService.debug("已更新收藏狀態。數量：\(favorites.count)")
    }
}
