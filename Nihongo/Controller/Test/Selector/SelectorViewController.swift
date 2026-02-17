import Combine
import FinnM0reSPM
import UIKit

class SelectorViewController:
    UIViewController,
    HasCancellable
{
    @Stylish
    private var valueView = UIView()

    @Stylish
    private var valueLabel = UILabel()

    @Stylish
    private var optionView = OptionView()

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

        observeSelection()
        observeOptions()
        observeNavigation()

        viewModel.fetchNextQuestion()
    }
}

// MARK: - UI

extension SelectorViewController {
    private func setupUI() {
        title = viewModel.theme.title
        view.backgroundColor = .backgroundPrimary

        $valueView
            .round(Design.Radius.m)
            .backgroundColor(.backgroundSecondary)
            .add(to: view)
            .makeConstraints { make in
                make.top.equalTo(view.snp.topMargin).offset(Design.Spacing.xl)
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.xl)
                make.height.equalTo(view.snp.height).dividedBy(4)
            }

        valueView.addHighlightGesture(
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

        $optionView
            .add(to: view)
            .makeConstraints { make in
                make.top.greaterThanOrEqualTo(valueLabel.snp.bottom).offset(Design.Spacing.xxxl)
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.xl)
                make.bottom.equalTo(view.snp.bottomMargin).inset(Design.Spacing.xl)
            }
    }
}

// MARK: - Observe

extension SelectorViewController {
    private func observeOptions() {
        viewModel
            .$options
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.valueLabel.text = $0.0
                self?.optionView.titles = $0.1

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if UserDefaults.isAutoSpeak {
                        self?.viewModel.speak()
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func observeSelection() {
        optionView
            .$selected
            .dropFirst()
            .sink(receiveValue: { [weak self] in
                self?.viewModel.checkAnswer($0)
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
