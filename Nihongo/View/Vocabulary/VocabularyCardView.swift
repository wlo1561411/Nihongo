import SwiftUI

/// 單字卡片 UI。
struct VocabularyCardView: View {
    /// 單字資料模型。
    struct StateItem: Identifiable, Hashable {
        /// 單字等級
        let level: JLPTLevel
        /// 日文漢字。
        let kanji: String
        /// 讀音。
        let kana: String
        /// 英文拼音。
        let romaji: String
        /// 是否收藏。
        var isFavorite: Bool = false
        
        /// 唯一識別。
        var id: String {
            "\(kanji)|\(romaji)|\(level.rawValue)"
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.pureWhite)
        .clipShape(.rect(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.borderPrimary, lineWidth: 1)
        )
        .shadow(color: Color.shadowPrimary, radius: 8, x: 0, y: 4)
        .buttonStyle(CardButtonPressStyle(cornerRadius: cornerRadius))
        .accessibilityElement(children: .combine)
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
                .buttonStyle(FavoriteTapAnimationStyle())
                .accessibilityLabel(item.isFavorite ? "Unfavorite" : "Favorite")
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

/// Favorite 按鈕點擊動畫樣式。
private struct FavoriteTapAnimationStyle: ButtonStyle {
    /// 按下時縮放比例。
    private let pressedScale: CGFloat = 0.9
    /// 按下時透明度。
    private let pressedOpacity = 0.65

    /// 建立按鈕樣式。
    /// - Parameter configuration: 按鈕配置狀態。
    /// - Returns: 套用縮放與漸變動畫後的按鈕視圖。
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .opacity(configuration.isPressed ? pressedOpacity : 1)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}

#Preview {
    VocabularyCardView(item: VocabularyCardView.StateItem(
        level: .n1,
        kanji: "先生",
        kana: "せんせい",
        romaji: "sensei",
        isFavorite: false
    ), onSelect: { }, onToggleFavorite: { }, onToggleSpeaker: { })
        .padding()
        .background(Color.backgroundPrimary)
}
