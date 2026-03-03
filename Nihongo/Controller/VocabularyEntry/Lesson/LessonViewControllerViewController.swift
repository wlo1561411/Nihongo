import FMUIKit
import UIKit

class LessonViewController: UIViewController, CompositionalLayoutBuildable {
//    private enum SectionKind: Int, CaseIterable {
//        case syllabary
//        case lesson
////        var vocabulary
////        var greetingPhrases
////        var sentencePatterns
//    }
//
//    @Stylish
//    private var collectionView = UICollectionView(
//        frame: .zero,
//        collectionViewLayout: .init())
//
//    let viewModel: ViewModel
//
//    init(viewModel: ViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
}

// MARK: - UI

//extension LessonViewController {
//    private func setupUI() {
//        view.backgroundColor = .backgroundPrimary
//
//        $collectionView
//            .backgroundColor(.clear)
//            .closeIndicator()
//            .collectionViewLayout(buildLayout())
//            .register(Cell.self, identifier: Cell.reuseIdentifier)
//            .register(Header.self, type: .header, identifier: "header")
//            .contentInset(.init(
//                top: 0,
//                left: 0,
//                bottom: Design.Spacing.xl,
//                right: 0))
//            .delegate(self)
//            .dataSource(self)
//            .add(to: view)
//            .makeConstraints { make in
//                make.edges.equalToSuperview()
//            }
//    }
//
//    private func buildLayout() -> UICollectionViewLayout {
//        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
//            guard let self else {
//                return nil
//            }
//
//            let section: NSCollectionLayoutSection
//
//            switch SectionKind(rawValue: sectionIndex) ?? .syllabary {
//            case .syllabary:
//                section = makeSyllabarySection()
//            case .lesson:
//                section = makeLessonSection()
//            }
//
//            section.boundarySupplementaryItems = [
//                .init(
//                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)),
//                    elementKind: UICollectionView.elementKindSectionHeader,
//                    alignment: .top)
//            ]
//
//            return section
//        }
//    }
//
//    private func makeSyllabarySection() -> NSCollectionLayoutSection {
//        let twoItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1 / 2),
//            heightDimension: .estimated(44)))
//
//        let twoColumnGroup = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1),
//                heightDimension: .estimated(44)),
//            subitems: [twoItem, twoItem])
//        twoColumnGroup.interItemSpacing = .fixed(Design.Spacing.l)
//
//        let oneItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .estimated(44)))
//
//        let oneColumnGroup = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .estimated(44)),
//            subitems: [oneItem])
//
//        let verticalGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .estimated(44)),
//            subitems: [twoColumnGroup, oneColumnGroup])
//        verticalGroup.interItemSpacing = .fixed(Design.Spacing.l)
//
//        let section = NSCollectionLayoutSection(group: verticalGroup)
//        section.interGroupSpacing = Design.Spacing.l
//        section.contentInsets = NSDirectionalEdgeInsets(
//            top: 0,
//            leading: Design.Spacing.l,
//            bottom: Design.Spacing.l,
//            trailing: Design.Spacing.l)
//
//        return section
//    }
//
//    private func makeLessonSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1 / 3),
//            heightDimension: .estimated(44))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .estimated(44)),
//            repeatingSubitem: item,
//            count: 3)
//        group.interItemSpacing = .fixed(Design.Spacing.l)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = Design.Spacing.l
//        section.contentInsets = NSDirectionalEdgeInsets(
//            top: 0,
//            leading: Design.Spacing.l,
//            bottom: Design.Spacing.l,
//            trailing: Design.Spacing.l)
//
//        return section
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension LessonViewController: UICollectionViewDataSource {
//    func numberOfSections(in _: UICollectionView) -> Int {
//        viewModel.numberOfSections()
//    }
//
//    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel.numberOfItems(in: section)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        viewForSupplementaryElementOfKind kind: String,
//                        at indexPath: IndexPath)
//        -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: "header",
//            for: indexPath) as! Header
//
//        header.update(title: viewModel.sectionTitle(at: indexPath.section))
//
//        return header
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: Cell.reuseIdentifier,
//                for: indexPath) as? Cell
//        else {
//            return UICollectionViewCell()
//        }
//
//        let item = viewModel.item(at: indexPath)
//        cell.configure(title: item.title, description: item.description)
//        return cell
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//
//extension LessonViewController: UICollectionViewDelegate {
//    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let theme = viewModel.theme(at: indexPath)
//        let item = viewModel.item(at: indexPath)
//        item.onTapped(theme, self)
//    }
//}

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
                make.bottom.equalToSuperview().inset(Design.Spacing.xl)
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.m)
            }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(title: String) {
        titleLabel.text = title
    }
}

// MARK: - Cell

private final class Cell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"

    @Stylish
    private var titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, description: String) {
        let attributedTitle = title.attributed
            .font(.systemFont(ofSize: 18, weight: .semibold))
            .textColor(.textPrimary)
            .lineSpacing(Design.Spacing.s)

        if !description.isEmpty {
            let attributedDescription = "\n\(description)".attributed
                .font(.systemFont(ofSize: 14, weight: .regular))
                .textColor(.textSecondary)

            attributedTitle.append(attributedDescription)
        }

        titleLabel.attributedText = attributedTitle
    }

    private func setupUI() {
        backgroundColor = .clear

        contentView.backgroundColor = .backgroundSecondary
        contentView.layer.cornerRadius = Design.Radius.m
        contentView.layer.masksToBounds = true

        $titleLabel
            .textColor(.textPrimary)
            .font(.systemFont(ofSize: 18, weight: .semibold))
            .numberOfLines(2)
            .add(to: contentView)
            .makeConstraints { make in
                make.edges.equalToSuperview().inset(Design.Spacing.l)
            }
    }
}
