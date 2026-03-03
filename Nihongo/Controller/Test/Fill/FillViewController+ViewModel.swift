import FMUIKit
import UIKit

extension FillViewController {
    class ViewModel:
        VoicePlayable,
        QuestionHandleable {
        private(set) var theme: Theme

        var items: [ItemProtocol]
        var currentItem: ItemProtocol?

        @Published
        var option: String?

        @Published
        var clearInput: Void?

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

extension FillViewController.ViewModel {
    func fetchNextQuestion() {
        option = currentItem?.description
    }

    func speak() {
        guard UserDefaults.isAutoSpeak
        else {
            return
        }

        speakJapanese(
            currentItem?.inputText,
            rate: theme.voicePlaybackRate)
    }

    func checkAnswer(_ input: String?) {
        guard currentItem?.inputText == input
        else {
            return
        }

        updateToNextQuestion()
    }

    func updateToNextQuestion() {
        prepareForNextQuestion()
        clearInput = ()
    }

    func endTest() {
        backToRoot = ()
    }
}
