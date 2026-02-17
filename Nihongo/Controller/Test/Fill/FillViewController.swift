import Combine
import FinnM0reSPM
import UIKit

class FillViewController:
    UIViewController,
    HasCancellable,
    KeyboardMovement
{
    @Stylish
    private var valueView = UIView()

    @Stylish
    private var valueLabel = UILabel()

    @Stylish
    private var inputField = UITextField()

    private let messagePopoverView = MessagePopoverView()

    let viewModel: ViewModel

    var cancellables: Set<AnyCancellable> = []

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

        handleKeyboardInteraction()
        setupSwipeSkipAction(#selector(handleSwipeLeft))

        observeOption()
        observeNavigation()

        viewModel.fetchNextQuestion()
    }
}

// MARK: - UI

extension FillViewController {
    private func setupUI() {
        title = viewModel.theme.title
        view.backgroundColor = .backgroundPrimary

        UIStackView(
            arrangedSubviews: [
                valueView,
                inputField
            ],
            spacing: Design.Spacing.xl,
            axis: .vertical,
            distribution: .equalSpacing,
            alignment: .center)
            .sr
            .add(to: view)
            .makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.xl)
            }

        $valueView
            .round(Design.Radius.m)
            .backgroundColor(.backgroundSecondary)
            .makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(view.snp.height).dividedBy(5).priority(999)
                make.height.greaterThanOrEqualTo(150)
            }

        messagePopoverView.popoverBackgroundColor = .black
        messagePopoverView.messageTextColor = .yellow

        valueView.addHighlightGesture(
            onHighlight: { [weak self] in
                guard let self else {
                    return
                }
                if $0 {
                    let frame = valueLabel.convert(valueLabel.bounds, to: nil)
                    let popPoint = CGPoint(x: frame.minX, y: frame.minY)
                    messagePopoverView.pop(
                        [viewModel.currentItem?.inputText ?? ""],
                        at: popPoint,
                        to: valueLabel,
                        onItemSelected: nil,
                        onDismiss: nil)
                } else {
                    messagePopoverView.dismiss()
                }
            },
            onClick: { [weak self] in
                self?.viewModel.speak()
            })

        $valueLabel
            .textAlignment(.center)
            .numberOfLines(2)
            .adjustsFontSizeToFitWidth(true)
            .minimumScaleFactor(0.5)
            .font(.systemFont(ofSize: 36, weight: .bold))
            .textColor(.textPrimary)
            .add(to: valueView)
            .makeConstraints { make in
                make.edges.equalToSuperview().inset(Design.Spacing.xl)
            }

        $inputField
            .borderStyle(.none)
            .font(.systemFont(ofSize: 18, weight: .regular))
            .textAlignment(.center)
            .textColor(.textPrimary)
            .tintColor(.textPrimary)
            .round(Design.Radius.xl)
            .borderColor(.backgroundHighlight)
            .borderWidth(2)
            .delegate(self)
            .makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(48)
            }
    }

    private func setupSwipeSkipAction(_ selector: Selector) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: selector)
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }

    @objc
    private func handleSwipeLeft() {
        viewModel.updateToNextQuestion()
    }
}

// MARK: - Observe

extension FillViewController {
    private func observeOption() {
        viewModel
            .$option
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.valueLabel.text = $0

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if UserDefaults.isAutoSpeak {
                        self?.viewModel.speak()
                    }

                    self?.inputField.becomeFirstResponder()
                }
            }
            .store(in: &cancellables)

        viewModel
            .$clearInput
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.inputField.text = ""
            })
            .store(in: &cancellables)
    }

    private func observeNavigation() {
        viewModel
            .$backToRoot
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            })
            .store(in: &cancellables)
    }
}

// MARK: - UI

extension FillViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.checkAnswer(textField.text)
        return true
    }
}
