import FMUIKit
import UIKit

class SyllabaryViewController:
    UIViewController,
    CompositionalLayoutBuildable {
    @Stylish
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - UI

extension SyllabaryViewController {
    private func setupUI() {
        title = viewModel.pageTitle

        view.backgroundColor = .backgroundPrimary

        $collectionView
            .closeIndicator()
            .backgroundColor(.clear)
            .collectionViewLayout(buildLayout())
            .register(Cell.self, identifier: "cell")
            .register(Header.self, type: .header, identifier: "header")
            .dataSource(self)
            .delegate(self)
            .add(to: view)
            .makeConstraints { make in
                make.edges.equalToSuperview()
            }
            .other {
                $0.contentInset.bottom = Design.Spacing.xl
            }
    }

    private func buildLayout() -> UICollectionViewLayout {
        let columns = max(1, viewModel.numberOfRowsInGrid)
        let itemWidth = CGFloat(1.0) / CGFloat(columns)
        let item = item(width: .fractionalWidth(itemWidth), height: .fractionalHeight(1))
        let group = group(
            axis: .horizontal,
            width: .fractionalWidth(1),
            height: .absolute(78),
            repeatingSubitem: item,
            count: viewModel.numberOfRowsInGrid,
            spacing: .fixed(Design.Spacing.s),
            contentInset: .init(
                top: 0,
                leading: Design.Spacing.xl,
                bottom: Design.Spacing.m,
                trailing: Design.Spacing.xl))
        let section = section(group: group)
        section.boundarySupplementaryItems = [
            supplementaryItem(
                width: .fractionalWidth(1),
                height: .estimated(50),
                elementKind: UICollectionView.elementKindSectionHeader)
        ]

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - DataSource

extension SyllabaryViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        viewModel.getNumberOfSections()
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItems(section: section)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath)
        -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "header",
            for: indexPath) as! Header

        header.update(title: viewModel.getSection(index: indexPath.section).title)

        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        let item = viewModel.getItem(indexPath: indexPath)

        cell.update(title: item.title, content: item.description)

        return cell
    }
}

// MARK: - Delegate

extension SyllabaryViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getItem(indexPath: indexPath)
        viewModel.speak(by: item)
    }
}

// MARK: - Header

private class Header: UICollectionReusableView {
    @Stylish
    var titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        $titleLabel
            .font(.systemFont(ofSize: 24, weight: .bold))
            .textColor(.textPrimary)
            .textAlignment(.left)
            .add(to: self)
            .makeConstraints { make in
                make.top.equalToSuperview().inset(Design.Spacing.xs)
                make.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.xxl)
            }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(title: String) {
        $titleLabel
            .text(title)
            .updateConstraints { make in
                make.bottom.equalToSuperview().inset(title.isEmpty ? 0 : Design.Spacing.l)
            }
    }
}

// MARK: - Cell

private class Cell: UICollectionViewCell {
    @Stylish
    var titleLabel = UILabel()
    @Stylish
    var contentLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        $titleLabel
            .font(.systemFont(ofSize: 20, weight: .semibold))
            .textColor(.textPrimary)
            .textAlignment(.center)
            .adjustsFontSizeToFitWidth(true)
            .minimumScaleFactor(0.5)
            .unwrap()

        $contentLabel
            .font(.systemFont(ofSize: 18, weight: .regular))
            .textColor(.textSecondary)
            .textAlignment(.center)
            .unwrap()

        UIStackView(
            arrangedSubviews: [titleLabel, contentLabel],
            spacing: Design.Spacing.s,
            axis: .vertical,
            distribution: .fill,
            alignment: .fill)
            .sr
            .add(to: contentView)
            .makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(Design.Spacing.s)
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.l)
            }

        contentView.sr
            .backgroundColor(.backgroundSecondary)
            .round(Design.Radius.s)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
