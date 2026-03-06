import SwiftUI

struct QuizView: View {
    @EnvironmentObject
    private var router: AppRouter

    var body: some View {
        ChooseLevelView(viewModel: .init(
            title: "Quiz",
            subTitle: "Select a JLPT level.",
            levels: ChooseLevelViewModel.defaultLevels.map {
                var new = $0
                new.actionTitle = "Start Quizzing"
                return new
            },
            onSelectLevel: { level in
                // todo
            }
        ))
    }
}
