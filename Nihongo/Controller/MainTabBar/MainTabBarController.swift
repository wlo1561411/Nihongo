import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let test = TestViewController()
        test.tabBarItem = .init(title: "Test", image: .init(systemName: "book.pages.fill"), tag: 0)
        let lesson = LessonViewController()
        lesson.tabBarItem = .init(title: "Lesson", image: .init(systemName: "character.book.closed.fill"), tag: 1)

        let controller = [test, lesson]

        title = controller.first?.tabBarItem.title
        setViewControllers(controller, animated: true)
        selectedIndex = 0
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = item.title
    }
}
