import FMUIKit
import UIKit

final class SettingViewController: UIViewController {
    @Stylish
    private var containerView = UIView()

    @Stylish
    private var autoSpeakTitleLabel = UILabel()

    @Stylish
    private var autoSpeakDescriptionLabel = UILabel()

    @Stylish
    private var autoSpeakSwitch = UISwitch()

    @Stylish
    private var darkModeContainerView = UIView()

    @Stylish
    private var darkModeTitleLabel = UILabel()

    @Stylish
    private var darkModeDescriptionLabel = UILabel()

    @Stylish
    private var darkModeSwitch = UISwitch()

    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        syncAutoSpeak()
        syncDarkMode()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - UI

extension SettingViewController {
    private func setupUI() {
        title = "設定"

        view.backgroundColor = .backgroundPrimary

        $autoSpeakTitleLabel
            .font(.systemFont(ofSize: 18, weight: .semibold))
            .textColor(.textPrimary)
            .text("自動朗讀")
            .unwrap()

        $autoSpeakDescriptionLabel
            .font(.systemFont(ofSize: 14, weight: .regular))
            .textColor(.textSecondary)
            .numberOfLines(0)
            .text("答題時自動朗讀日文")
            .unwrap()

        let labelStack = UIStackView(
            arrangedSubviews: [
                autoSpeakTitleLabel,
                autoSpeakDescriptionLabel
            ],
            spacing: Design.Spacing.xs,
            axis: .vertical,
            distribution: .fill,
            alignment: .leading)
        .sr

        let rowStack = UIStackView(
            arrangedSubviews: [
                labelStack.unwrap(),
                autoSpeakSwitch
            ],
            spacing: Design.Spacing.m,
            axis: .horizontal,
            distribution: .fill,
            alignment: .center)
        .sr

        autoSpeakSwitch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

        $darkModeTitleLabel
            .font(.systemFont(ofSize: 18, weight: .semibold))
            .textColor(.textPrimary)
            .text("深色模式")
            .unwrap()

        $darkModeDescriptionLabel
            .font(.systemFont(ofSize: 14, weight: .regular))
            .textColor(.textSecondary)
            .numberOfLines(0)
            .text("不跟隨系統，強制深色或淺色")
            .unwrap()

        let darkModeLabelStack = UIStackView(
            arrangedSubviews: [
                darkModeTitleLabel,
                darkModeDescriptionLabel
            ],
            spacing: Design.Spacing.xs,
            axis: .vertical,
            distribution: .fill,
            alignment: .leading)
        .sr

        let darkModeRowStack = UIStackView(
            arrangedSubviews: [
                darkModeLabelStack.unwrap(),
                darkModeSwitch
            ],
            spacing: Design.Spacing.m,
            axis: .horizontal,
            distribution: .fill,
            alignment: .center)
        .sr

        darkModeSwitch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

        $containerView
            .round(Design.Radius.m)
            .backgroundColor(.backgroundSecondary)
            .add(to: view)
            .makeConstraints { make in
                make.top.equalTo(view.snp.topMargin).inset(Design.Spacing.xl)
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.xl)
            }

        rowStack
            .add(to: containerView)
            .makeConstraints { make in
                make.edges.equalToSuperview().inset(Design.Spacing.l)
            }

        $darkModeContainerView
            .round(Design.Radius.m)
            .backgroundColor(.backgroundSecondary)
            .add(to: view)
            .makeConstraints { make in
                make.top.equalTo(containerView.snp.bottom).offset(Design.Spacing.m)
                make.leading.trailing.equalToSuperview().inset(Design.Spacing.xl)
            }

        darkModeRowStack
            .add(to: darkModeContainerView)
            .makeConstraints { make in
                make.edges.equalToSuperview().inset(Design.Spacing.l)
            }

        autoSpeakSwitch.addTarget(
            self,
            action: #selector(handleAutoSpeakSwitchChanged),
            for: .valueChanged)

        darkModeSwitch.addTarget(
            self,
            action: #selector(handleDarkModeSwitchChanged),
            for: .valueChanged)
    }
}

// MARK: - Actions

extension SettingViewController {
    private func syncAutoSpeak() {
        autoSpeakSwitch.isOn = viewModel.isAutoSpeak
    }

    private func syncDarkMode() {
        darkModeSwitch.isOn = viewModel.isDarkModeEnabled
    }

    @objc
    private func handleAutoSpeakSwitchChanged() {
        viewModel.setAutoSpeak(autoSpeakSwitch.isOn)
    }

    @objc
    private func handleDarkModeSwitchChanged() {
        viewModel.setDarkModeEnabled(darkModeSwitch.isOn)
        applyInterfaceStyle(isDarkModeEnabled: darkModeSwitch.isOn)
    }

    private func applyInterfaceStyle(isDarkModeEnabled: Bool) {
        let style: UIUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
        if let window = view.window {
            window.overrideUserInterfaceStyle = style
        } else {
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .forEach { $0.overrideUserInterfaceStyle = style }
        }
    }
}
