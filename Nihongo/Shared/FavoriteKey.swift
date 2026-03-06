import Foundation

/// 建立單字收藏使用的穩定 Key。
enum FavoriteKey {
    /// 產生收藏 Key。
    /// - Parameters:
    ///   - word: 單字漢字或原文字。
    ///   - furigana: 單字假名。
    ///   - level: JLPT 等級。
    /// - Returns: 組合後的收藏 Key。
    static func make(word: String, furigana: String, level: JLPTLevel) -> String {
        "\(word)|\(furigana)|\(level.rawValue)"
    }
}
