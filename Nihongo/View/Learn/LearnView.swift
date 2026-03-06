import SwiftUI

struct LearnView: View {
    @EnvironmentObject
    private var router: AppRouter

    var body: some View {
        ChooseLevelView(viewModel: .init(
            title: "Choose Your Level",
            subTitle: "Select a JLPT level.",
            onSelectLevel: { level in
                router.push(.vocabulary(level: level))
            }))
    }
}
