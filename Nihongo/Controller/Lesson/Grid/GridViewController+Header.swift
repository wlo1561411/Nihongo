import FinnM0reSPM
import UIKit

extension GridViewController {
    class Header: UICollectionReusableView {
        @Stylish
        var titleLabel = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)

            $titleLabel
                .font(.systemFont(ofSize: 20, weight: .semibold))
                .textColor(.white)
                .textAlignment(.center)
                .add(to: self)
                .makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.leading.trailing.equalToSuperview().inset(10)
                }

        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func update(title: String) {
            $titleLabel
                .text(title)
                .updateConstraints { make in
                    make.top.bottom.equalToSuperview().inset(title.isEmpty ? 0 : 10)
                }
        }
    }
}
