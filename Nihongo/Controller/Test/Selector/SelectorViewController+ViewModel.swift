import Combine
import FinnM0reSPM
import UIKit

extension SelectorViewController {
    class ViewModel:
        VoicePlayable,
        QuestionHandleable {
        private(set) var theme: Theme

        var items: [ItemProtocol]
        var currentItem: ItemProtocol?

        @Published
        var options: (String?, [String]) = (nil, [])

        @Published
        var backToRoot: Void?

        init(theme: Theme) {
            self.theme = theme
            self.items = theme.shuffled()

            self.currentItem = items.first
        }
    }
}

// MARK: - Data Handle

extension SelectorViewController.ViewModel {
    func fetchNextQuestion() {
        options = (currentItem?.displayText, getOptions())
    }

    private func getOptions() -> [String] {
        var options = [currentItem?.description ?? ""]
        options.append(
            contentsOf: theme
                .shuffled(count: 3)
                .map {
                    $0.description
                })
        return options.shuffled()
    }

    func speak() {
        speakJapanese(
            currentItem?.inputText,
            rate: theme.voicePlaybackRate)
    }

    func checkAnswer(_ input: String?) {
        guard
            currentItem?.description == input
        else {
            return
        }

        prepareForNextQuestion()
    }

    func endTest() {
        backToRoot = ()
    }
}
