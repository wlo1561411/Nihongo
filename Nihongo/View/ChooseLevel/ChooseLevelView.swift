import SwiftUI

/// JLPT 等級選擇入口畫面。
struct ChooseLevelView: View {
    /// 提供等級選擇的狀態與事件處理。
    @StateObject
    private var viewModel: ChooseLevelViewModel

    /// 建立等級選擇畫面。
    init(viewModel: ChooseLevelViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    /// 主要內容視圖。
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                    .zIndex(1)

                scroll
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }

    /// 頁首標題區塊。
    private var header: some View {
        VStack(spacing: 8) {
            Text(viewModel.title)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.textPrimary)

            Text(viewModel.subTitle)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 10)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity)
        .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.pureWhite)
                .ignoresSafeArea(edges: .top)
        )
        .shadow(
            color: Color.shadowPrimary,
            radius: 8,
            x: 0,
            y: 4
        )
    }

    /// 等級選擇區塊。
    private var scroll: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.levels) { level in
                    let isSelected = level.id == viewModel.selectedLevelID
                    LevelCardView(
                        model: level,
                        isSelected: isSelected,
                        onSelect: { viewModel.selectLevel(level) },
                        onConfirm: { viewModel.confirmLevel(level) }
                    )
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 24)
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        ChooseLevelView(viewModel: .init(title: "Test", subTitle: "this is a sub title", onSelectLevel: { _ in }))
    }
}
