import UIKit

protocol SwipeSkippable: UIViewController { }

extension SwipeSkippable {
    func setupSwipeSkipAction(_ selector: Selector) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: selector)
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
}
