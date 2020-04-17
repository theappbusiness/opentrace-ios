//
//  HowItWorksViewController.swift
//  OpenTrace

import UIKit
import FirebaseAuth

final class HowItWorksViewController: UIViewController {

    private typealias Copy = DisplayStrings.Onboarding.HowItWorks

    @IBOutlet private var greatBtn: StyledButton!
    
	@IBOutlet private var stackView: UIStackView!
	@IBOutlet private var titleLabel: UILabel!
	@IBOutlet private var subTitleLabel: UILabel!
	private let loadingView = LoadingView()
 
    @IBAction func greatBtnOnClick(_ sender: UIButton) {
  
        OnboardingManager.shared.completedIWantToHelp = true
        loadingView.show()
        Auth.auth().signInAnonymously { [weak self] (result, error) in
            self?.loadingView.hide()
            if error != nil || result == nil {
                self?.showError()
                return
            }
            self?.performSegue(withIdentifier: "iWantToHelpToConsentSegue", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func showError() {
        let alert = UIAlertController.buildGenericAlert()
        present(alert, animated: true, completion: nil) 
    }

    private func setup() {
		titleLabel.text = Copy.header
		subTitleLabel.text = Copy.body
        greatBtn.setTitle(Copy.footerButtonTitle, for: .normal)
		stackView.spacing = 19
//        view.addAndPin(subview: loadingView)
		setupPermissions()
    }

	private func setupPermissions() {
		let termsAndPrivacyCheck = PermissionView()
		termsAndPrivacyCheck.configure(with: "You agree to our Terms of use and privacy policy and we take this matter serious. ", onCheck: {_ in})
		let pushNotificationCheck = PermissionView()
		pushNotificationCheck.configure(with: "Agree to have push notifications. Please remember to switch these on.", onCheck: { isChecked in
			if isChecked {
				// Turn on push
			} else {
				//turn off push
			}
		})
		let bluetoothPermission = PermissionView()
		bluetoothPermission.configure(with: "You agree to accept our bluetooth data sharing without any personal data.", onCheck: { isChecked in
			// do something
		})

		[termsAndPrivacyCheck, pushNotificationCheck, bluetoothPermission].forEach { stackView.addArrangedSubview($0) }
	}
}

final class PermissionView: UIView {

	private let checkBoxButton = UIButton()
	private let label = UILabel()
	private var checkButtonAction: ((Bool) -> Void)?

	var isChecked: Bool {
		return checkBoxButton.isSelected
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	private func setup() {
		[checkBoxButton, label].forEach { view in
			addSubview(view)
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
		label.numberOfLines = 0
		setupConstraints()
		checkBoxButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchDown)
	}

	func configure(with text: String, onCheck checkAction: @escaping (Bool) -> Void) {
		label.text = text
		checkButtonAction = checkAction
	}

	@objc private func checkButtonTapped() {
		checkBoxButton.isSelected = !checkBoxButton.isSelected
		checkButtonAction?(isChecked)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			checkBoxButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			checkBoxButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
			checkBoxButton.heightAnchor.constraint(equalToConstant: 24),
			checkBoxButton.widthAnchor.constraint(equalTo: checkBoxButton.heightAnchor),

			label.topAnchor.constraint(equalTo: checkBoxButton.topAnchor),
			label.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 18),
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -37)
		])
	}
}
