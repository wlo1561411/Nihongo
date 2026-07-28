import SwiftUI

/// 單字卡片 UI。
struct VocabularyCardView: View {
    /// 單字資料模型。
    struct StateItem: Identifiable, Hashable, Sendable {
        /// diff 使用的穩定識別。
        let id: String
        /// 單字等級
        let level: JLPTLevel
        /// 日文漢字。
        let kanji: String
        /// 讀音。
        let kana: String
        /// 英文拼音。
        let romaji: String
        /// 翻譯意思。
        let meaning: String
        /// 是否收藏。
        var isFavorite: Bool = false

        /// 建立單字卡片狀態。
        init(
            level: JLPTLevel,
            kanji: String,
            kana: String,
            romaji: String,
            meaning: String,
            isFavorite: Bool = false
        ) {
            self.id = "\(kanji)|\(romaji)|\(level.rawValue)"
            self.level = level
            self.kanji = kanji
            self.kana = kana
            self.romaji = romaji
            self.meaning = meaning
            self.isFavorite = isFavorite
        }
    }

    /// 單字資料。
    let item: StateItem
    /// 點擊卡片行為。
    let onSelect: () -> Void
    /// 收藏切換行為。
    let onToggleFavorite: () -> Void
    /// 點擊喇叭行為。
    let onToggleSpeaker: () -> Void

    /// 卡片圓角。
    @ScaledMetric
    private var cornerRadius: CGFloat = 18
    /// 卡片內距。
    @ScaledMetric
    private var contentPadding: CGFloat = 14

    /// 主要內容視圖。
    var body: some View {
        Button(action: onSelect) {
            label
        }
        .buttonStyle(CardButtonPressStyle(cornerRadius: cornerRadius))
    }

    var label: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    if item.kana.isEmpty == false {
                        Text(item.kana)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.accentBluePrimary)
                    }

                    Text(item.kanji)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(item.meaning)
                        .italic()
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.textSecondary)
                        .lineLimit(2)
                }

                Spacer(minLength: 8)

                Button(action: onToggleFavorite) {
                    Image(systemName: item.isFavorite ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(item.isFavorite ? Color.accentYellowPrimary : Color.textThirdly)
                        .animation(item.isFavorite ? .easeInOut(duration: 0.18) : nil, value: item.isFavorite)
                }
                .buttonStyle(IconButtonPressStyle())
            }

            HStack {
                Text(item.romaji)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.textSecondary)
                    .lineLimit(1)

                Spacer(minLength: 8)

                Button(action: onToggleSpeaker) {
                    Image(systemName: "speaker.wave.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.accentBluePrimary)
                }
            }
        }
    }
}

#Preview {
    VocabularyCardView(item: VocabularyCardView.StateItem(
        level: .n1,
        kanji: "先生",
        kana: "せんせい",
        romaji: "sensei",
        meaning: "老師",
        isFavorite: false
    ), onSelect: { }, onToggleFavorite: { }, onToggleSpeaker: { })
        .padding()
        .background(Color.backgroundPrimary)
}
