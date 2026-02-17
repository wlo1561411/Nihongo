import UIKit

extension VocabularyEntryController {
    class ViewModel: TestViewController.ViewModel {
        override func itemAction(by theme: any Theme, at controller: UIViewController) {
            switch theme {
            case let theme as JapaneseSyllabaryTheme:
                controller.navigationController?.pushViewController(
                    SyllabaryViewController(viewModel: .init(theme: theme)),
                    animated: true)
            default:
                // todo
                return
            }
        }
    }
}
