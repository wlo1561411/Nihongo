import AVFoundation
import FinnM0reSPM
import UIKit

extension GridViewController {
    class ViewModel: VoicePlayable {
        private(set) var theme: Theme

        private let sections: [Theme.Section]

        init(theme: Theme) {
            self.theme = theme
            self.sections = theme.sectionsForGrid()
        }
    }
}

// MARK: - Data Handle

extension GridViewController.ViewModel {
    func getNumberOfSections() -> Int {
        sections.count
    }

    func getSection(index: Int) -> Theme.Section {
        sections[index]
    }

    func getNumberOfItems(section: Int) -> Int {
        sections[section].items.count
    }

    func getItem(indexPath: IndexPath) -> ItemProtocol {
        getSection(index: indexPath.section).items[indexPath.row]
    }

    func speak(indexPath: IndexPath) {
        speakJapanese(
            getItem(indexPath: indexPath).inputText,
            rate: theme.voicePlaybackRate)
    }
}

