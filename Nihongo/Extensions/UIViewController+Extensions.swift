import UIKit

extension UIViewController {
    func presentActionSheet(
        on viewController: UIViewController,
        title: String? = nil,
        message: String? = nil,
        actions: [(String, UIAlertAction.Style, ((UIAlertAction) -> Void)?)])
    {
        let actionSheet = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet)

        for action in actions {
            let alertAction = UIAlertAction(
                title: action.0,
                style: action.1,
                handler: action.2)
            actionSheet.addAction(alertAction)
        }

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel, 
            handler: nil)
        actionSheet.addAction(cancelAction)

        viewController.present(
            actionSheet,
            animated: true,
            completion: nil)
    }
}
