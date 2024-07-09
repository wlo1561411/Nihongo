import Combine
import FinnM0reSPM
import UIKit

class OptionView: UIView, HasCancellable {
    @Stylish
    private var stackView = UIStackView(
        spacing: 20,
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .fill)

    private var buttons = [UIButton]()

    var titles = [String]() {
        didSet {
            resetUI()
        }
    }

    @SealPublished
    var selected: String?

    var cancellable: Set<AnyCancellable> = []

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension OptionView {
    private func setupUI() {
        buttons = (0..<4).map(buildButton(tag:))

        $stackView
            .add(to: self)
            .addArranged(buttons)
            .makeConstraints { make in
                make.edges.equalToSuperview()
            }
    }

    private func resetUI() {
        for button in buttons {
            button.sr
                .isEnabled(true)
                .borderColor(.white)
                .title(titles[safe: button.tag])
                .unwrap()
        }
    }

    private func buildButton(tag: Int) -> UIButton {
        let button = UIButton().sr
            .tag(tag)
            .titleColor(.white, state: .normal)
            .titleColor(.darkGray, state: .disabled)
            .backgroundColor(.black)
            .font(.systemFont(ofSize: 20))
            .round(8)
            .borderColor(.white)
            .borderWidth(2)
            .unwrap()

        button.addHighlightGesture(
            onHighlight: { [weak button] in
                button?.sr
                    .titleColor($0 ? .darkGray : .white)
                    .borderColor($0 ? .darkGray : .white)
            },
            onClick: { [weak self, weak button] in
                guard let self, let button else { return }

                button.isEnabled = !button.isEnabled
                button.sr.borderColor(.darkGray)
                _selected.send(button.title(for: .normal))
            })

        return button
    }
}
