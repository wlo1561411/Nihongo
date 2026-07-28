import FMFoundation
import Foundation

protocol VocabularyStore {
    func fetch(level: JLPTLevel) async throws -> [Vocabulary]
}

/// 管理 JLPT 全單字清單的下載與本地快取。
actor JLPTVocabularyStore: VocabularyStore {
    static let shared = JLPTVocabularyStore()

    /// Log 用途的 logger。
    private let logService: LogService

    /// 目前載入在記憶體中的單字清單。
    /// - Important: 只有在 `fetch()` 成功後才會更新。
    private(set) var vocabulary: [Vocabulary] = []

    /// 建立 Store 實例。
    /// - Note: 僅允許單例使用。
    private init(logService: LogService = LoggerService.shared) {
        self.logService = logService
    }

    /// 取得全單字清單，優先讀取本地 JSON，無檔案時才下載。
    ///
    /// - Important: 成功下載後會寫入本地快取。
    /// - Returns: 全單字清單。
    func fetch(level: JLPTLevel) async throws -> [Vocabulary] {
        guard vocabulary.isEmpty else {
            logService.info("已經載入過單字清單。數量：\(self.vocabulary.count)")
            return vocabulary.filter { $0.level == level.rawValue }
        }

        do {
            logService.debug("從本地快取載入單字清單。")
            let vocabulary = try await loadFromLocal()
            self.vocabulary = vocabulary
            logService.info("已從快取載入單字清單。數量：\(vocabulary.count)")
            return vocabulary.filter { $0.level == level.rawValue }
        } catch {
            // 本地無檔案或解碼失敗時，改走下載。
            logService.notice("快取不存在或解碼失敗。原因：\(error.localizedDescription)")
        }

        logService.info("從 API 下載單字清單。")
        let vocabulary = try await JLPTAPI.AllVocabularyRequest().send()
        self.vocabulary = vocabulary

        saveToLocal(vocabulary)

        logService.info("已從 API 下載單字清單。數量：\(vocabulary.count)")
        return vocabulary.filter { $0.level == level.rawValue }
    }

    /// 讀取本地快取的 JSON 檔。
    ///
    /// - Returns: 本地快取的單字清單。
    /// - Note: 會直接讀取檔案並解碼為模型。
    private func loadFromLocal() async throws -> [Vocabulary] {
        let url = try localFileURL()
        let data = try Data(contentsOf: url)
        let vocabulary = try JSONDecoder().decode([Vocabulary].self, from: data)
        return vocabulary
    }

    /// 將單字清單寫入本地 JSON 檔。
    ///
    /// - Parameter vocabulary: 要快取的單字清單。
    /// - Note: 寫入失敗會記錄 Log，但不會阻擋主流程。
    private func saveToLocal(_ vocabulary: [Vocabulary]) {
        Task { [weak self] in
            guard let self else {
                return
            }

            do {
                let url = try localFileURL()
                let data = try JSONEncoder().encode(vocabulary)
                try data.write(to: url, options: [.atomic])

                logService.info("已寫入單字清單到本地快取。數量：\(vocabulary.count)")
            } catch {
                logService.error("寫入單字清單快取失敗。原因：\(error.localizedDescription)")
            }
        }
    }

    /// 快取檔案位置（Application Support）。
    /// - Returns: 快取檔案 URL。
    /// - Note: 會確保目錄存在。
    private nonisolated func localFileURL() throws -> URL {
        let fileManager = FileManager.default
        let baseURL = try fileManager.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let directoryURL = baseURL.appending(path: "Nihongo", directoryHint: .isDirectory)
        try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        return directoryURL.appending(path: "all_vocabulary.json")
    }
}
