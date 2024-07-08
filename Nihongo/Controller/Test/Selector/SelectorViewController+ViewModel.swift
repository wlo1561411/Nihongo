import FinnM0reSPM
import UIKit

extension SelectorViewController {
    class ViewModel:
        VoicePlayable,
        QuestionHandleable
    {
        private(set) var theme: Theme

        var items: [ItemProtocol]
        var currentItem: ItemProtocol?

        @SealPublished
        var options: (String?, [String]) = (nil, [])

        @SealPublished
        var backToRoot: Void?

        init(theme: Theme) {
            self.theme = theme
            self.items = theme.shuffled()

            currentItem = items.first
        }
    }
}

// MARK: - Data Handle

extension SelectorViewController.ViewModel {
    func fetchNextQuestion() {
        _options.send((self.currentItem?.value, getOptions()))
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
            currentItem?.speakText,
            rate: theme.voicePlaybackRate)
    }

    func checkAnswer(_ input: String?) {
        guard
            currentItem?.description == input
        else { return }

        prepareForNextQuestion()
    }

    func endTest() {
        _backToRoot.send(())
    }
}
