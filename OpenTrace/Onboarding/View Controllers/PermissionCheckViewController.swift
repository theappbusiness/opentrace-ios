//
//  PermissionCheckViewCOntroller.swift
//  OpenTrace

import UIKit
import FirebaseAuth
import SafariServices

final class PermissionCheckViewController: UIViewController {

    private typealias Copy = DisplayStrings.Onboarding.PermissionCheck

    @IBOutlet private var footerButton: StyledButton!
    
	@IBOutlet private var stackView: UIStackView!
	@IBOutlet private var titleLabel: UILabel!
	@IBOutlet private var subTitleLabel: UILabel!
	private let loadingView = LoadingView()

	private let termsAndPrivacyCheck = PermissionView()
	private let pushNotificationCheck = PermissionView()
	private let bluetoothPermission = PermissionView()

 
    @IBAction func footerButtonTapped(_ sender: UIButton) {
		guard permissionsAreValid() else { return }
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
        footerButton.setTitle(Copy.footerButtonTitle, for: .normal)
		stackView.spacing = 19
        view.addAndPin(subview: loadingView)
		setupPermissions()
    }

	private func setupPermissions() {
		termsAndPrivacyCheck.configure(with: Copy.termsAndPrivacyPolicyText,
									   linkText: [.init(text: Copy.privacyPolicyHighlightedText, link: "https://www.google.com/" ),
												  .init(text: Copy.termsHighlightedText, link: "https://www.google.com/" )], delegate: self, onCheck: { [weak self] in
			self?.termsAndPrivacyCheck.isChecked = true
		})
		pushNotificationCheck.configure(with: Copy.noticationText, delegate: self, onCheck: { [weak self] in
			self?.enableBluetoothPermissions()
		})
		bluetoothPermission.configure(with: Copy.bluetoothText, delegate: self, onCheck: { [weak self] in
			self?.bluetoothPermission.isChecked = true
		})

		[termsAndPrivacyCheck, pushNotificationCheck, bluetoothPermission].forEach { stackView.addArrangedSubview($0) }
	}

	private func enableBluetoothPermissions() {
		BlueTraceLocalNotifications.shared.checkAuthorization { [weak self] granted in
			if granted  {
				self?.pushNotificationCheck.isChecked = true
			} else {
				self?.presentNotificationAccessAlert()
				self?.pushNotificationCheck.isChecked = false
			}
		}
	}

	private func permissionsAreValid() -> Bool {
		guard [termsAndPrivacyCheck, pushNotificationCheck, bluetoothPermission].allSatisfy({ $0.isChecked == true}) else {
			let alert = UIAlertController(title: Copy.PermissionsValidationError.title, message: Copy.PermissionsValidationError.message, preferredStyle: .alert)
			alert.addAction(.init(title: DisplayStrings.General.ok, style: .default))
			present(alert, animated: true)
			return false
		}
		return true
	}

	private func presentNotificationAccessAlert() {
		let alert = UIAlertController(title: Copy.NotificationError.title, message: Copy.NotificationError.message, preferredStyle: .alert)
		alert.addAction(.init(title: DisplayStrings.General.ok, style: .default))
		present(alert, animated: true)
	}
}

extension PermissionCheckViewController: PermissionViewDelegate {
	func didTapLink(url: URL) {
		let safariVC = SFSafariViewController(url: url)
		present(safariVC, animated: true)
	}
}
