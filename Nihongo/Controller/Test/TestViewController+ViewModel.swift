import UIKit

extension TestViewController {
    class ViewModel: ThemesViewController.ViewModel {
        override func itemAction(by theme: any Theme, at controller: UIViewController) {
            controller.presentActionSheet(
                actions: [
                    ("選擇題", .default, { [weak controller] _ in
                        controller?.navigationController?
                            .pushViewController(
                                SelectorViewController(viewModel: .init(theme: theme)),
                                animated: true)
                    }),
                    ("填空題", .default, { [weak controller] _ in
                        controller?.navigationController?
                            .pushViewController(
                                FillViewController(viewModel: .init(theme: theme)),
                                animated: true)
                    })
                ])
        }
    }
}
