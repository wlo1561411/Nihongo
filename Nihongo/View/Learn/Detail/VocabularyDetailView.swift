import SwiftUI

struct VocabularyDetailView: View {
    @State
    private var viewModel: VocabularyDetailViewModel

    private let contentId = "content"

    init(viewModel: VocabularyDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    card

                    upcomingCards(onTapped: {
                        withAnimation {
                            proxy.scrollTo(contentId, anchor: .top)
                        }
                    })
                    .padding(.top, 12)
                }
                .padding(16)
                .id(contentId)
            }
        }
        .navigationTitle("\(viewModel.word)")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.backgroundPrimary)
        .task { @concurrent in
            await viewModel.load()
        }
    }

    private var card: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VocabularyWordsView(
                    title: viewModel.word,
                    titleSize: 36,
                    subTitle: viewModel.furigana,
                    subTitleSize: 16,
                    meaning: viewModel.meaning,
                    meaningSize: 20
                )

                Spacer(minLength: 8)

                FavoriteButton(
                    size: 24,
                    isFavorite: viewModel.isFavorite
                ) { _ in
                    Task {
                        await viewModel.toggleFavorite()
                    }
                }
            }

            Spacer().frame(height: 24)

            exampleButton

            Spacer().frame(height: 24)

            HStack {
                partOfSpeech

                Spacer(minLength: 8)

                SpeakerButton {
                    viewModel.playWordVoice()
                }
            }
        }
        .padding(24)
        .background(Color.pureWhite)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(
            color: Color.shadowPrimary,
            radius: 8,
            x: 0,
            y: 4
        )
        .fixedSize(horizontal: false, vertical: true)
    }

    private var exampleButton: some View {
        Button(
            action: {
                viewModel.playExampleVoice()
            },
            label: {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "text.bubble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 17)
                        .foregroundStyle(Color.accentBluePrimary)

                    VStack(spacing: 4) {
                        Text(viewModel.example)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(viewModel.translatedExample)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(2)
                    }
                }
                .padding(16)
                .background(
                    Color.backgroundSecondary,
                    in: RoundedRectangle(cornerRadius: 16)
                )
            }
        )
        .buttonStyle(
            IconButtonPressStyle(
                pressedScale: 0.9,
                pressedOpacity: 1
            )
        )
    }

    private var partOfSpeech: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(viewModel.partOfSpeech, id: \.abbreviation) { partOfSpeech in
                    Text(partOfSpeech.abbreviation)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(partOfSpeech.primaryColor)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(partOfSpeech.secondaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .scrollIndicators(.never)
    }

    private func upcomingCards(onTapped: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Upcoming")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.textThirdly)

            VocabularyCardsView(
                cardStates: viewModel.upcomingVocabularyCardStates,
                spacing: 12,
                onSelect: { item in
                    Task {
                        await viewModel.reload(for: item)
                        onTapped()
                    }
                },
                onToggleFavorite: { item in
                    Task {
                        await viewModel.toggleFavorite(for: item)
                    }
                }
            )
        }
    }
}

#Preview {
    let json = """
    [
    {
    "word": "毎朝",
    "furigana": "まいあさ",
    "romaji": "maiasa",
    "level": 5,
    "meaning_en": "every morning",
    "meaning_zh": "每天早上",
    "part_of_speech": [
      "Noun",
      "Adverb"
    ],
    "example": {
      "ja": "私は毎朝六時に起きます。",
      "zh": "我每天早上六點起床。",
      "en": "I wake up at six o'clock every morning."
    }
    },
    {
    "word": "問題",
    "furigana": "もんだい",
    "romaji": "mondai",
    "level": 5,
    "meaning_en": "problem",
    "meaning_zh": "問題",
    "part_of_speech": [
      "Noun"
    ],
    "example": {
      "ja": "あなたはどのようにしてその問題を解いたのですか。",
      "zh": "你是如何解決這個問題的？",
      "en": "How did you solve that problem?"
    }
    },
    {
    "word": "お茶",
    "furigana": "おちゃ",
    "romaji": "ocha",
    "level": 5,
    "meaning_en": "green tea",
    "meaning_zh": "茶",
    "part_of_speech": [
      "Noun"
    ],
    "example": {
      "ja": "ご都合のよいときにお茶を飲みにお寄りになりませんか。",
      "zh": "方便的時候，要不要順路來喝杯綠茶？",
      "en": "Why not stop by for a cup of tea at your convenience?"
    }
    },
    {
    "word": "黒",
    "furigana": "くろ",
    "romaji": "kuro",
    "level": 5,
    "meaning_en": "black",
    "meaning_zh": "黑色的",
    "part_of_speech": [
      "Noun",
      "Particle"
    ],
    "example": {
      "ja": "２匹犬を飼っているが、１匹は白でもう１匹は黒だ。",
      "zh": "我有兩隻狗，一隻是白的，另一隻是黑的。",
      "en": "I have two dogs, one is white and the other is black."
    }
    }
    ]
    """

    guard let data = json.data(using: .utf8),
          let mocks = try? JSONDecoder().decode([LocalVocabulary].self, from: data),
          let first = mocks.first
    else {
        return Text("fail")
    }

    return NavigationStack {
        VocabularyDetailView(viewModel: .init(
            word: first.word,
            furigana: first.furigana,
            romaji: first.romaji,
            meaning: first.meaning_zh,
            example: first.example(by: .ja),
            translatedExample: first.example(by: .zh),
            partOfSpeech: first.partOfSpeech,
            isFavorite: false,
            upcomingVocabularies: mocks
        ))
    }
}
