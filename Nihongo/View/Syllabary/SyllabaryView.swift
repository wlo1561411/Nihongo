import SwiftUI

struct SyllabaryView: View {
    @ScaledMetric
    private var maxHeaderOffset: CGFloat = 70
    @State
    private var scrollOffset: CGFloat = 0

    private var headerOffset: CGFloat {
        min(max(scrollOffset, -maxHeaderOffset), 0)
    }

    @State
    private var viewModel = SyllabaryViewModel()

    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                header
                    .offset(y: headerOffset)
                    .padding(.bottom, headerOffset)
                    .zIndex(1)

                scroll
                    .padding(.horizontal, 10)
                    .padding(.top, 20)
            }
            .safeAreaPadding(.bottom, 40)
        }
        .task(id: viewModel.selectedType) {
            await viewModel.load()
        }
    }

    private var header: some View {
        VStack(spacing: 0) {
            Text("Syllabary")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(Color.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(1 - (-headerOffset / maxHeaderOffset))

            Spacer().frame(height: 20)

            picker

            Spacer().frame(height: 10)

            Text("Gojūon")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer().frame(height: 4)

            Text("The basic 46 characters. Tap to hear pronunciation.")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.textThirdly)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding([.bottom, .horizontal], 20)
        .padding(.top, 10)
        .frame(maxWidth: .infinity)
        .background(
            Color.surfacePrimary
                .overlay {
                    Ellipse()
                        .fill(Color.accentBluePrimary.opacity(0.2))
                        .frame(width: 450, height: 400)
                        .offset(x: -120, y: -120)
                }
                .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                .ignoresSafeArea(edges: .top)
        )
    }

    private var picker: some View {
        HStack(spacing: 0) {
            ForEach(SyllabaryType.allCases) { type in
                Button {
                    viewModel.selectedType = type
                } label: {
                    Text(type.displayName)
                        .padding(30)
                        .frame(height: 40)
                }
                .buttonStyle(
                    PrimaryButtonPressStyle(
                        isSelected: viewModel.selectedType == type,
                        textFontSize: 16,
                        unselectedBackgroundColor: .clear
                    )
                )
            }
        }
        .padding(5)
        .background(
            Capsule()
                .fill(Color.accentBlueSecondary)
        )
    }

    private let gridItem: [GridItem] = [
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10),
    ]

    private var scroll: some View {
        ObservableScrollView(
            onChange: {
                scrollOffset = $0.y
            },
            content: {
                LazyVGrid(columns: gridItem, spacing: 10) {
                    sections
                }
            }
        )
        .scrollIndicators(.never)
    }

    private var sections: some View {
        ForEach(viewModel.sections, id: \.title) { section in
            Section(
                content: {
                    ForEach(section.syllables, id: \.id) { syllable in
                        card(syllable: syllable)
                    }
                },
                header: {
                    if !section.title.isEmpty {
                        Text(section.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(Color.textSecondary)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            )
        }
    }

    private func card(syllable: any Syllable) -> some View {
        Button(
            action: {
                viewModel.playVoice(for: syllable)
            },
            label: {
                VStack(spacing: 2) {
                    Text(syllable.character)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.textPrimary)

                    Text(syllable.reading)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.textThirdly)
                }
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
            }
        )
        .buttonStyle(
            CardButtonPressStyle(
                cornerRadius: 8,
                padding: 0
            )
        )
        .opacity(syllable.character.isEmpty ? 0 : 1)
    }
}

#Preview {
    SyllabaryView()
}
