import FinnM0reSPM
import UIKit

class MainViewController: UIViewController {
    @Stylish
    private var tableView = UITableView()

    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI

extension MainViewController {
    private func setupUI() {
        title = UIApplication.shared.appName

        $tableView
            .closeIndicator()
            .separatorInset(.init(top: 0, left: 15, bottom: 0, right: 15))
            .delegate(self)
            .dataSource(self)
            .register(UITableViewCell.self, identifier: "cell")
            .add(to: view)
            .makeConstraints { make in
                make.edges.equalToSuperview()
            }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.repository.themes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.selectionStyle = .none
        cell.textLabel?.text = viewModel.repository.themes[indexPath.row].title
        cell.textLabel?.numberOfLines = 0

        return cell
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            SelectorViewController(viewModel: .init(
                theme: viewModel.repository.themes[indexPath.row])),
            animated: true)
    }
}
