import SwiftUI

/// 顯示 JLPT 等級對應的單字清單頁面。
struct VocabularyView: View {
    /// 單字清單畫面的狀態與事件管理者。
    @StateObject
    private var viewModel: VocabularyViewModel

    @Environment(\.dismiss)
    private var dismiss

    @FocusState
    private var isFocused: Bool

    /// 單字卡片的欄位配置。
    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), spacing: 16, alignment: .top),
    ]

    /// 建立單字清單畫面。
    /// - Parameter level: 目前選取的 JLPT 等級。
    init(viewModel: VocabularyViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    /// 主要內容視圖。
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
                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(viewModel.currentItems) { item in
                            VocabularyCardView(
                                item: item,
                                onSelect: { },
                                onToggleFavorite: {
                                    Task {
                                        await viewModel.toggleFavorite(for: item)
                                    }
                                },
                                onToggleSpeaker: {
                                    viewModel.playVoice(for: item)
                                }
                            )
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .scrollIndicators(.never)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
                .accessibilityLabel("Back")
            }
        }
        .task { @concurrent in
            await viewModel.loadVocabulary()
        }
        .task(id: viewModel.searchText) {
            await viewModel.updateFilteredItems()
        }
        .onDisappear {
            viewModel.saveFavorite()
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
            VocabularyCardView.StateItem(
                level: .n5,
                kanji: "食べる",
                kana: "たべる",
                romaji: "taberu",
                meaning: "吃",
                isFavorite: false
            ),
            VocabularyCardView.StateItem(
                level: .n5,
                kanji: "水",
                kana: "みず",
                romaji: "mizu",
                meaning: "水",
                isFavorite: true
            ),
            VocabularyCardView.StateItem(
                level: .n5,
                kanji: "大きい",
                kana: "おおきい",
                romaji: "ookii",
                meaning: "很大",
                isFavorite: false
            ),
        ]

        VocabularyView(viewModel: .init(
            level: .n5,
            store: nil,
            favoritesStore: nil,
            vocabularyItems: mock
        ))
    }
}
