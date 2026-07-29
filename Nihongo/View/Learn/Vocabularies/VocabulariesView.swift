import SwiftUI

/// 顯示 JLPT 等級對應的單字清單頁面。
struct VocabulariesView: View {
    @StateObject
    private var viewModel: VocabulariesViewModel

    @EnvironmentObject
    private var router: AppRouter

    @Environment(\.dismiss)
    private var dismiss

    @FocusState
    private var isFocused: Bool

    init(viewModel: VocabulariesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            searchBar
                .padding(.top, 16)

            ScrollView {
                switch viewModel.viewState {
                case .empty:
                    EmptyStateView()
                        .padding(.top, 48)
                case .loading:
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.top, 48)
                case .finish:
                    VocabularyCardsView(
                        cardStates: viewModel.currentCardStates,
                        spacing: 16,
                        hasSpeaker: true,
                        onSelect: {
                            if let viewModel = viewModel.makeDetailViewModel(for: $0) {
                                router.push(.vocabularyDetail(viewModel: viewModel))
                            }
                        },
                        onToggleFavorite: { item in
                            Task {
                                await viewModel.toggleFavorite(for: item)
                            }
                        },
                        onToggleSpeaker: {
                            viewModel.playVoice(for: $0)
                        }
                    )
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .scrollIndicators(.never)
        }
        .padding(.horizontal, 20)
        .background(Color.backgroundPrimary)
        .navigationTitle("\(viewModel.level.displayName) Vocabulary")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.accentBluePrimary)
                        .frame(width: 20, height: 20)
                }
            }
        }
        .task { @concurrent in
            await viewModel.loadVocabulary()
        }
        .task(id: viewModel.searchText) {
            await viewModel.updateSearchItems()
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                isFocused = false
            }
        )
    }

    /// 搜尋列視圖。
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.textThirdly)

            TextField(
                "",
                text: $viewModel.searchText,
                prompt: Text("Search vocabulary...")
                    .foregroundStyle(Color.textThirdly)
            )
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(Color.textPrimary)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($isFocused)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.pureWhite)
        .clipShape(.rect(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.borderPrimary, lineWidth: 1)
        )
        .shadow(color: Color.shadowPrimary, radius: 8, x: 0, y: 4)
    }
}

/// 搜尋無結果時的提示畫面。
private struct EmptyStateView: View {
    /// 主要內容視圖。
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "questionmark.text.page.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .foregroundStyle(Color.textSecondary)

            Spacer(minLength: 8)

            Text("No results")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.textPrimary)

            Text("Try a different keyword.")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
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

        VocabulariesView(viewModel: .init(
            level: .n5,
            vocabularyStore: nil,
            favoritesStore: nil,
            vocabularyCardStates: mock
        ))
    }
}
