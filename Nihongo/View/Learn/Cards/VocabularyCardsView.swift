import SwiftUI

struct VocabularyCardsView: View {
    /// 單字資料模型。
    struct CardState: Identifiable, Equatable {
        /// 單字等級
        let level: JLPTLevel
        /// 日文漢字。
        let word: String
        /// 讀音。
        let furigana: String
        /// 英文拼音。
        let romaji: String
        /// 翻譯意思。
        let meaning: String
        /// 是否收藏。
        var isFavorite: Bool = false

        /// diff 使用的穩定識別。
        var id: String {
            word
        }
    }

    let cardStates: [CardState]
    let spacing: CGFloat
    let gridColumns: [GridItem]

    /// 是否有朗讀按鈕。
    let hasSpeaker: Bool
    /// 點擊卡片行為。
    let onSelect: (CardState) -> Void
    /// 收藏切換行為。
    let onToggleFavorite: (CardState) -> Void
    /// 點擊喇叭行為。
    let onToggleSpeaker: (CardState) -> Void

    init(
        cardStates: [CardState],
        spacing: CGFloat,
        hasSpeaker: Bool,
        onSelect: @escaping (CardState) -> Void,
        onToggleFavorite: @escaping (CardState) -> Void,
        onToggleSpeaker: @escaping (CardState) -> Void
    ) {
        self.cardStates = cardStates
        self.spacing = spacing
        self.hasSpeaker = hasSpeaker
        self.onSelect = onSelect
        self.onToggleFavorite = onToggleFavorite
        self.onToggleSpeaker = onToggleSpeaker
        self.gridColumns = [
            .init(.flexible(), spacing: spacing, alignment: .top),
            .init(.flexible(), spacing: spacing, alignment: .top),
        ]
    }

    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: spacing) {
            ForEach(cardStates) { state in
                card(state: state)
            }
        }
    }

    func card(state: CardState) -> some View {
        Button(
            action: {
                onSelect(state)
            },
            label: {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            if state.furigana.isEmpty == false {
                                Text(state.furigana)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.accentBluePrimary)
                            }

                            Text(state.word)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundStyle(Color.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(state.meaning)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color.textSecondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(2)
                        }

                        Button(
                            action: {
                                onToggleFavorite(state)
                            },
                            label: {
                                Image(systemName: state.isFavorite ? "star.fill" : "star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(state.isFavorite ? Color.accentYellowPrimary : Color.textThirdly)
                                    .animation(state.isFavorite ? .easeInOut(duration: 0.18) : nil, value: state.isFavorite)
                            }
                        )
                        .buttonStyle(IconButtonPressStyle())
                    }

                    HStack(spacing: 8) {
                        Text(state.romaji)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.textSecondary)
                            .lineLimit(1)

                        if hasSpeaker {
                            Button(
                                action: {
                                    onToggleSpeaker(state)
                                },
                                label: {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                        .foregroundStyle(Color.accentBluePrimary)
                                }
                            )
                        }
                    }
                }
            }
        )
        .buttonStyle(CardButtonPressStyle())
    }
}
