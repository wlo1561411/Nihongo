import Combine
import FMUIKit
import UIKit

class OptionView: UIView {
    @Stylish
    private var stackView = UIStackView(
        spacing: Design.Spacing.l,
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .fill)

    private var buttons = [UIButton]()

    var titles = [String]() {
        didSet {
            resetUI()
        }
    }

    @Published
    var selected: String?

    var cancellables: Set<AnyCancellable> = []

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

        buttons.chunked(into: 2)
            .forEach {
                let row = UIStackView(arrangedSubviews: $0)
                row.spacing = stackView.spacing
                row.distribution = .fillEqually
                row.alignment = .fill
                stackView.addArrangedSubview(row)
                row.snp.makeConstraints { make in
                    make.width.equalTo(row.snp.height).priority(.high)
                }
            }

        $stackView
            .add(to: self)
            .makeConstraints { make in
                make.edges.equalToSuperview()
            }
    }

    private func resetUI() {
        for button in buttons {
            button.sr
                .isEnabled(true)
                .borderColor(.textMuted)
                .title(titles[safe: button.tag])
                .unwrap()
        }
    }

    private func buildButton(tag: Int) -> UIButton {
        let button = UIButton().sr
            .tag(tag)
            .titleColor(.textPrimary, state: .normal)
            .titleColor(.textDisabled, state: .disabled)
            .backgroundColor(.backgroundSecondary)
            .font(.systemFont(ofSize: 18, weight: .semibold))
            .round(Design.Radius.xl)
            .unwrap()

        button.snp.makeConstraints { make in
            make.height.equalTo(button.snp.width).priority(.high)
        }

        button.addHighlightGesture(
            onHighlight: { [weak button] in
                button?.sr
                    .backgroundColor($0 ? .backgroundHighlight : .backgroundSecondary)
                    .titleColor(.textPrimary)
                    .borderColor($0 ? .textPrimary : .textMuted)
            },
            onClick: { [weak self, weak button] in
                guard let self, let button else {
                    return
                }

                button.isEnabled = !button.isEnabled
                selected = button.title(for: .normal)
            })

        return button
    }
}
