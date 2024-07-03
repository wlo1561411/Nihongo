import AVFoundation
import FinnM0reSPM
import UIKit

extension SelectorViewController {
    class ViewModel {
        private let synthesizer = AVSpeechSynthesizer()
        private let theme: Theme

        private var items: ItemMap
        private var currentItem: ItemProtocol?

        @SealPublished
        var options: (String?, [String]) = (nil, [])

        @SealPublished
        var backToRoot: Void?

        init(theme: Theme) {
            self.theme = theme
            self.items = theme.shuffled()

            currentItem = items.values.first
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
                .allItems
                .keys
                .prefix(3)
                .map {
                    theme.allItems[$0]?.description ?? ""
                })
        return options.shuffled()
    }

    func read() {
        guard let text = currentItem?.value else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.ja-JP.Kyoko")
        utterance.rate = theme.voiceRate

        synthesizer.speak(utterance)
    }

    func checkAnswer(_ description: String?) {
        guard
            let currentItem,
            currentItem.description == description
        else { return }

        items.removeValue(forKey: currentItem.value)
        self.currentItem = items.values.first

        if items.isEmpty {
            _backToRoot.send(())
        }
        else {
            fetch()
        }
    }
}
