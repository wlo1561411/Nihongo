import SwiftUI

struct VocabularyDetailView: View {
    @State
    private var viewModel: VocabularyDetailViewModel

    init(viewModel: VocabularyDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            card
            otherCards
        }
        .navigationTitle("\(viewModel.vocabulary.word)")
        .navigationBarTitleDisplayMode(.inline)
        .padding(16)
        .background(Color.backgroundPrimary)
    }

    var card: some View {
        VStack(alignment: .leading) {
            let vocabulary = viewModel.vocabulary

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    if vocabulary.furigana.isEmpty == false {
                        Text(vocabulary.furigana)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.accentBluePrimary)
                    }

                    Text(vocabulary.word)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(Color.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(vocabulary.meaning(by: .zh))
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)
                }

                Spacer(minLength: 8)

                Button(
                    action: {
                        Task {
                            await viewModel.toggleFavorite()
                        }
                    },
                    label: {
                        Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(viewModel.isFavorite ? Color.accentYellowPrimary : Color.textThirdly)
                            .animation(viewModel.isFavorite ? .easeInOut(duration: 0.18) : nil, value: viewModel.isFavorite)
                    }
                )
                .buttonStyle(IconButtonPressStyle())
            }

            Spacer().frame(height: 24)

            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "text.bubble")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                    .foregroundStyle(Color.accentBluePrimary)

                VStack(spacing: 4) {
                    Text(vocabulary.example(by: .ja))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(vocabulary.example(by: .zh))
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

            Spacer().frame(height: 24)

            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 8) {
                        ForEach(vocabulary.partOfSpeech, id: \.abbreviation) { partOfSpeech in
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

                Spacer(minLength: 8)

                Button(
                    action: {
                        viewModel.playVoice(for: vocabulary)
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

    var otherCards: some View {
        ScrollView {
            EmptyView()
        }
    }
}

#Preview {
    let json = """
      {
        "word": "毎朝",
        "furigana": "まいあさ",
        "romaji": "maiasa",
        "level": 5,
        "meaning_en": "every morning",
        "meaning_zh": "每天早上",
        "part_of_speech": [
          "Noun",
          "Adverb",
          "Counter",
          "Expression",
          "Interjection",
          "Numeral",
          "Prenominal"
        ],
        "example": {
          "ja": "私は毎朝六時に起きます。",
          "zh": "我每天早上六點起床。",
          "en": "I wake up at six o'clock every morning."
        }
      }
    """

    guard let data = json.data(using: .utf8),
          let mock = try? JSONDecoder().decode(LocalVocabulary.self, from: data)
    else {
        return Text("fail")
    }

    return NavigationStack {
        VocabularyDetailView(viewModel: .init(
            vocabulary: mock,
            isFavorite: false,
            favoritesStore: nil
        ))
    }
}
