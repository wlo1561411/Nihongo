import FinnM0reSPM
import UIKit

extension GridViewController {
    class Cell: UICollectionViewCell {
        @Stylish
        var titleLabel = UILabel()
        @Stylish
        var contentLabel = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)

            $titleLabel
                .font(.systemFont(ofSize: 20, weight: .semibold))
                .textColor(.white)
                .textAlignment(.center)
                .unwrap()

            $contentLabel
                .font(.systemFont(ofSize: 18, weight: .regular))
                .textColor(.white)
                .textAlignment(.center)
                .unwrap()

            UIStackView(
                arrangedSubviews: [titleLabel, contentLabel],
                spacing: 8,
                axis: .vertical,
                distribution: .fill,
                alignment: .fill)
            .sr
            .add(to: contentView)
            .makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(10)
                make.leading.trailing.equalToSuperview().inset(10)
            }

            contentView.sr
                .round(8)
                .borderColor(.white)
                .borderWidth(2)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func update(title: String, content: String) {
            if title.isEmpty {
                contentView.sr.borderColor(.darkGray)
            } else {
                contentView.sr.borderColor(.white)
            }

            titleLabel.text = title
            contentLabel.text = content
        }
    }
}
