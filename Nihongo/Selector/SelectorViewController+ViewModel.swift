import AVFoundation
import FinnM0reSPM
import UIKit

extension SelectorViewController {
    class ViewModel {
        private let synthesizer = AVSpeechSynthesizer()
        private let theme: Theme

        private var items: [any ItemProtocol]
        private var currentItem: ItemProtocol?

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
    func fetch() {
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

    func read() {
        guard
            var text = currentItem?.value
        else { return }

        let split = text.split(separator: "\n")

        if split.count != 1, let last = split.last {
            text = "\(last)"
        }

        text = text.replacingOccurrences(of: "〜", with: "")

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.ja-JP.Kyoko")
        utterance.rate = theme.voiceRate

        synthesizer.speak(utterance)
    }

    func checkAnswer(_ description: String?) {
        guard
            let currentItem,
            let index = items.firstIndex(where: { currentItem.value == $0.value }),
            currentItem.description == description
        else { return }

        items.remove(at: index)
        self.currentItem = items.first

        if items.isEmpty {
            _backToRoot.send(())
        }
        else {
            fetch()
        }
    }
}
