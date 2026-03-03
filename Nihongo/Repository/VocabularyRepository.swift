import FMFoundation
import Foundation
import os

/// 管理 JLPT 全單字清單的下載與本地快取。
final class VocabularyRepository {
    /// 全域共用的 Repository 實例。
    static let shared = VocabularyRepository()

    /// Log 用
    private nonisolated let logger: Logger

    /// 目前載入在記憶體中的單字清單。
    private(set) var vocabulary: [JLPTAPI.Vocabulary] = []

    private init() {
        self.logger = Logger(Self.self)
    }

    /// 取得全單字清單，優先讀取本地 JSON，無檔案時才下載。
    ///
    /// - Important: 會在成功下載後寫入本地。
    func fetch() async throws -> [JLPTAPI.Vocabulary] {
        do {
            logger.debug("Load vocabulary from local cache.")
            let vocabulary = try await loadFromLocal()
            self.vocabulary = vocabulary
            logger.info("Loaded vocabulary from cache. Count: \(vocabulary.count)")
            return vocabulary
        } catch {
            // 本地無檔案或解碼失敗時，改走下載。
            logger.notice("Cache miss or decode failed. Error: \(error.localizedDescription)")
        }

        logger.info("Downloading vocabulary from API.")
        let vocabulary = try await JLPTAPI.AllVocabularyRequest().send()
        self.vocabulary = vocabulary

        saveToLocal(vocabulary)

        logger.info("Downloaded vocabulary from API. Count: \(vocabulary.count)")
        return vocabulary
    }

    /// 讀取本地快取的 JSON 檔。
    ///
    /// - Returns: 本地快取的單字清單。
    @concurrent
    private func loadFromLocal() async throws -> [JLPTAPI.Vocabulary] {
        let url = try localFileURL()
        let data = try Data(contentsOf: url)
        let vocabulary = try JSONDecoder().decode([JLPTAPI.Vocabulary].self, from: data)
        return vocabulary
    }

    /// 將單字清單寫入本地 JSON 檔。
    ///
    /// - Parameter vocabulary: 要快取的單字清單。
    private func saveToLocal(_ vocabulary: [JLPTAPI.Vocabulary]) {
        Task.detached { [weak self] in
            guard let self else {
                return
            }

            do {
                let url = try localFileURL()
                let data = try JSONEncoder().encode(vocabulary)
                try data.write(to: url, options: [.atomic])

                logger.info("Saved vocabulary to local cache. Count: \(vocabulary.count)")
            } catch {
                logger.error("Failed to save vocabulary cache. Error: \(error.localizedDescription)")
            }
        }
    }

    /// 快取檔案位置（Application Support）。
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
