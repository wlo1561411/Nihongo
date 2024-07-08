import Combine
import FinnM0reSPM
import UIKit

class FillViewController:
    UIViewController,
    HasCancellable,
    KeyboardMovement,
    SwipeSkippable
{
    @Stylish
    private var valueLabel = UILabel()

    @Stylish
    private var inputField = UITextField()

    let viewModel: ViewModel

    var cancellable: Set<AnyCancellable> = []

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
        view.backgroundColor = .black

        UIStackView(
            arrangedSubviews: [
                valueLabel,
                inputField
            ],
            spacing: 20,
            axis: .vertical,
            distribution: .equalSpacing,
            alignment: .center)
            .sr
            .add(to: view)
            .makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(20)
            }

        $valueLabel
            .textAlignment(.center)
            .numberOfLines(2)
            .adjustsFontSizeToFitWidth(true)
            .minimumScaleFactor(0.5)
            .font(.systemFont(ofSize: 40, weight: .bold))
            .textColor(.white)
            .round(8)
            .borderColor(.white)
            .borderWidth(2)
            .makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(200)
            }

        valueLabel.appendHighlightGesture(
            onClick: { [weak self] in
                self?.viewModel.speak()
            })

        $inputField
            .borderStyle(.none)
            .font(.systemFont(ofSize: 18, weight: .regular))
            .textAlignment(.center)
            .backgroundColor(.black)
            .round(8)
            .borderColor(.darkGray)
            .borderWidth(2)
            .delegate(self)
            .makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(50)
            }
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
            .publisher()
            .sink { [weak self] in
                self?.valueLabel.text = $0
            }
            .store(in: &cancellable)

        viewModel
            .$clearInput
            .publisher()
            .sink(receiveValue: { [weak self] _ in
                self?.inputField.text = ""
            })
            .store(in: &cancellable)
    }

    private func observeNavigation() {
        viewModel
            .$backToRoot
            .publisher()
            .sink(receiveValue: { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            })
            .store(in: &cancellable)
    }
}

// MARK: - UI

extension FillViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.checkAnswer(textField.text)
        return true
    }
}
