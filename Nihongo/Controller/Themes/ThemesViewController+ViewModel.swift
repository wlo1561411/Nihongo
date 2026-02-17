import UIKit

extension ThemesViewController {
    class ViewModel {
        struct Section {
            let title: String
            let items: [StateItem]
        }

        struct StateItem {
            let title: String
            let description: String
        }

        private let repository = ThemeRepository()
        private let themesBySection: [[Theme]]

        private var sections: [Section] = []

        init() {
            let syllabaryThemes = repository.themes.filter { $0 is JapaneseSyllabaryTheme }
            let lessonThemes = repository.themes.filter { $0 is LessonTheme }

            self.themesBySection = [syllabaryThemes, lessonThemes]

            self.sections = [
                .init(
                    title: "拼音",
                    items: syllabaryThemes.map {
                        .init(
                            title: $0.title,
                            description: $0.items.map(\.value).joined(separator: ","))
                    }),
                .init(
                    title: "課程",
                    items: lessonThemes.map {
                        let splited = $0.title.split(separator: " ").map(String.init)
                        return .init(
                            title: splited.first ?? "",
                            description: splited.last ?? "")
                    })
            ]
        }

        func itemAction(by theme: Theme, at controller: UIViewController) {
            // to override
        }
    }
}

extension ThemesViewController.ViewModel {
    func numberOfSections() -> Int {
        sections.count
    }

    func numberOfItems(in section: Int) -> Int {
        sections[section].items.count
    }

    func sectionTitle(at section: Int) -> String {
        sections[section].title
    }

    func item(at indexPath: IndexPath) -> StateItem {
        sections[indexPath.section].items[indexPath.item]
    }

    func theme(at indexPath: IndexPath) -> Theme {
        themesBySection[indexPath.section][indexPath.item]
    }
}
