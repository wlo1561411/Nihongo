import Combine
import FinnM0reSPM
import UIKit

final class MainTabBarController: UITabBarController, HasCancellable, UITabBarControllerDelegate {
    private lazy var controllers: [UIViewController] = [
        makeTestViewController(),
        makeLessonViewController(),
        makeSettingViewController()
    ]

    var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigated = controllers
            .map {
                UINavigationController(rootViewController: $0)
            }

        setViewControllers(navigated, animated: true)

        delegate = self

        selectedIndex = 0
        delegate?.tabBarController?(self, didSelect: navigated.first ?? .init())
    }

    private func makeTestViewController() -> UIViewController {
        let test = TestViewController()
        test.tabBarItem = .init(title: "隨堂考", image: .init(systemName: "book.pages.fill"), tag: 0)
        return test
    }

    private func makeLessonViewController() -> UIViewController {
        let lesson = VocabularyEntryController()
        lesson.tabBarItem = .init(title: "課程", image: .init(systemName: "character.book.closed.fill"), tag: 1)
        return lesson
    }

    private func makeSettingViewController() -> UIViewController {
        let setting = SettingViewController()
        setting.tabBarItem = .init(title: "設定", image: .init(systemName: "gearshape.fill"), tag: 2)
        return setting
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = selectedViewController as? UINavigationController else {
            return
        }

        navigationController.popToRootViewController(animated: true)
    }
}
