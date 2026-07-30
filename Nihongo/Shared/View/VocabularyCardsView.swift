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
        var isFavorite: Bool

        /// diff 使用的穩定識別。
        var id: String {
            word
        }

        init(
            level: JLPTLevel,
            word: String,
            furigana: String,
            romaji: String,
            meaning: String,
            isFavorite: Bool
        ) {
            self.level = level
            self.word = word
            self.furigana = furigana
            self.romaji = romaji
            self.meaning = meaning
            self.isFavorite = isFavorite
        }

        init(
            vocabulary: any Vocabulary,
            favorites: Set<String>,
            language: Language = .zh
        ) {
            self.level = vocabulary.level
            self.word = vocabulary.word
            self.furigana = vocabulary.furigana
            self.romaji = vocabulary.romaji
            self.meaning = vocabulary.meaning(by: language)
            self.isFavorite = favorites.contains(word)
        }
    }

    let cardStates: [CardState]
    let spacing: CGFloat
    let gridColumns: [GridItem]

    /// 點擊卡片行為。
    let onSelect: (CardState) -> Void
    /// 收藏切換行為。
    let onToggleFavorite: (CardState) -> Void
    /// 點擊喇叭行為。
    let onToggleSpeaker: ((CardState) -> Void)?

    init(
        cardStates: [CardState],
        spacing: CGFloat,
        onSelect: @escaping (CardState) -> Void,
        onToggleFavorite: @escaping (CardState) -> Void,
        onToggleSpeaker: ((CardState) -> Void)? = nil
    ) {
        self.cardStates = cardStates
        self.spacing = spacing
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

    private func card(state: CardState) -> some View {
        Button(
            action: {
                onSelect(state)
            },
            label: {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 8) {
                        VocabularyWordsView(
                            title: state.word,
                            titleSize: 22,
                            subTitle: state.furigana,
                            subTitleSize: 12,
                            meaning: state.meaning,
                            meaningSize: 16
                        )

                        FavoriteButton(isFavorite: state.isFavorite) { _ in
                            onToggleFavorite(state)
                        }
                    }

                    if let onToggleSpeaker {
                        HStack(spacing: 8) {
                            Text(state.romaji)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.textSecondary)
                                .lineLimit(1)

                            Spacer()

                            SpeakerButton {
                                onToggleSpeaker(state)
                            }
                        }
                    }
                }
            }
        )
        .buttonStyle(CardButtonPressStyle())
    }
}

#Preview {
    let mock = [
        VocabularyCardsView.CardState(
            level: .n5,
            word: "食べる",
            furigana: "たべる",
            romaji: "taberu",
            meaning: "吃",
            isFavorite: false
        ),
        VocabularyCardsView.CardState(
            level: .n5,
            word: "水",
            furigana: "みず",
            romaji: "mizu",
            meaning: "水",
            isFavorite: true
        ),
        VocabularyCardsView.CardState(
            level: .n5,
            word: "大きい",
            furigana: "おおきい",
            romaji: "ookii",
            meaning: "很大",
            isFavorite: false
        ),
    ]

    return VocabularyCardsView(
        cardStates: mock,
        spacing: 16,
        onSelect: { _ in },
        onToggleFavorite: { _ in },
        onToggleSpeaker: { _ in }
    )
    .padding()
}
