import AVFoundation
import FMUIKit
import UIKit

extension SyllabaryViewController {
    class ViewModel: VoicePlayable {
        struct Section {
            let title: String
            let items: [StateItem]
        }

        struct StateItem {
            let title: String
            let description: String
        }

        private var sections: [Section] = []

        let pageTitle: String
        let voicePlaybackRate: Float
        let numberOfRowsInGrid: Int = 5

        init(theme: JapaneseSyllabaryTheme) {
            self.pageTitle = theme.title
            self.voicePlaybackRate = theme.voicePlaybackRate
            self.sections = makeSections(by: theme)
        }
    }
}

// MARK: - Data Handle

extension SyllabaryViewController.ViewModel {
    private func makeSections(by theme: JapaneseSyllabaryTheme) -> [Section] {
        let sort: [String] = [
            "a", "i", "u", "e", "o",
            "ka", "ki", "ku", "ke", "ko",
            "sa", "shi", "su", "se", "so",
            "ta", "chi", "tsu", "te", "to",
            "na", "ni", "nu", "ne", "no",
            "ha", "hi", "fu", "he", "ho",
            "ma", "mi", "mu", "me", "mo",
            "ya", "", "yu", "", "yo",
            "ra", "ri", "ru", "re", "ro",
            "wa", "", "", "", "wo",
            "", "", "n", "", ""
        ]

        let group = Dictionary(grouping: theme.normalItems, by: \.description).compactMapValues(\.first)

        return [
            .init(title: "", items: sort.map {
                if let mapped = group[$0] {
                    return .init(title: mapped.value, description: mapped.description)
                }
                else {
                    return .init(title: "", description: "")
                }
            }),
            .init(title: "濁音", items: theme.voicedItem.map {
                .init(title: $0.value, description: $0.description)
            }),
            .init(title: "半濁音", items: theme.semiVoicedItem.map {
                .init(title: $0.value, description: $0.description)
            })
        ]
    }

    func getNumberOfSections() -> Int {
        sections.count
    }

    func getSection(index: Int) -> Section {
        sections[index]
    }

    func getNumberOfItems(section: Int) -> Int {
        sections[section].items.count
    }

    func getItem(indexPath: IndexPath) -> StateItem {
        getSection(index: indexPath.section).items[indexPath.row]
    }

    func speak(by item: StateItem) {
        speakJapanese(
            item.title,
            rate: voicePlaybackRate)
    }
}

