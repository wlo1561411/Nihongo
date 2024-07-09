import Combine
import FinnM0reSPM
import UIKit

class SelectorViewController:
    UIViewController,
    HasCancellable
{
    @Stylish
    private var valueLabel = UILabel()

    @Stylish
    private var optionView = OptionView()

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
            .add(to: view)
            .makeConstraints { make in
                make.top.equalTo(view.snp.topMargin).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(200)
            }

        valueLabel.addHighlightGesture(
            onClick: { [weak self] in
                self?.viewModel.speak()
            })

        $optionView
            .add(to: view)
            .makeConstraints { make in
                make.top.equalTo(valueLabel.snp.bottom).offset(50)
                make.leading.trailing.equalToSuperview().inset(20)
                make.bottom.equalTo(view.snp.bottomMargin).inset(20)
            }
    }
}

// MARK: - Observe

extension SelectorViewController {
    private func observeOptions() {
        viewModel
            .$options
            .publisher()
            .sink { [weak self] in
                self?.valueLabel.text = $0.0
                self?.optionView.titles = $0.1
            }
            .store(in: &cancellable)
    }

    private func observeSelection() {
        optionView
            .$selected
            .publisher()
            .sink(receiveValue: { [weak self] in
                self?.viewModel.checkAnswer($0)
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
