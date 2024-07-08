import FinnM0reSPM
import UIKit

class GridViewController:
    UIViewController,
    CompositionalLayoutBuildable
{
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
}

// MARK: - UI

extension GridViewController {
    private func setupUI() {
        title = viewModel.theme.title
        
        $collectionView
            .closeIndicator()
            .collectionViewLayout(buildLayout())
            .register(Cell.self, identifier: "cell")
            .register(Header.self, type: .header, identifier: "header")
            .dataSource(self)
            .delegate(self)
            .add(to: view)
            .makeConstraints { make in
                make.edges.equalToSuperview()
            }
    }

    private func buildLayout() -> UICollectionViewLayout {
        let size = item(width: .fractionalWidth(CGFloat(1 / viewModel.theme.numberOfRowsInGrid)), height: .fractionalHeight(1))
        let group = group(
            axis: .horizontal,
            width: .fractionalWidth(1),
            height: .absolute(80),
            repeatingSubitem: size,
            count: viewModel.theme.numberOfRowsInGrid,
            spacing: .fixed(5),
            contentInset: .init(top: 0, leading: 10, bottom: 5, trailing: 10))
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

extension GridViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        viewModel.getNumberOfSections()
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItems(section: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
        -> UICollectionReusableView
    {
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

        cell.update(title: item.value, content: item.description)

        return cell
    }
}

// MARK: - Delegate

extension GridViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.speak(indexPath: indexPath)
    }
}
