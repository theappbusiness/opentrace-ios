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
	@IBOutlet private var scrollView: UIScrollView!
	@IBOutlet private var footerView: UIView!

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
            self?.performSegue(withIdentifier: "permissionsToHome", sender: self)
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
		scrollView.delegate = self
		stackView.spacing = 19
        view.addAndPin(subview: loadingView)
		setupPermissions()
		footerView.apply(.footerCardShadow)
    }

	private func setupPermissions() {
		termsAndPrivacyCheck.configure(with: Copy.termsAndPrivacyPolicyText,
									   linkText: [.init(text: Copy.privacyPolicyHighlightedText, link: "https://www.google.com/" ),
												  .init(text: Copy.termsHighlightedText, link: "https://www.google.com/" )],
									   delegate: self,
									   onCheck: { [weak self] in
			self?.termsAndPrivacyCheck.isChecked = true
		})
		pushNotificationCheck.configure(with: Copy.noticationText, delegate: self, onCheck: { [weak self] in
			self?.enableBluetoothPermissions()
		})
		bluetoothPermission.configure(with: Copy.bluetoothText, delegate: self, onCheck: { [weak self] in
			self?.checkBluetoothStatus()
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

	private func checkBluetoothStatus() {
		let bluetoothIsPoweredOn = BluetraceManager.shared.isBluetoothOn()
        let bluetoothIsAuthorized = BluetraceManager.shared.isBluetoothAuthorized()
		if bluetoothIsPoweredOn && bluetoothIsAuthorized {
			bluetoothPermission.isChecked = true
		} else {
			bluetoothPermission.isChecked = false
			presentBluetoothNotEnabledAlert()
		}
	}

	private func permissionsAreValid() -> Bool {
		guard [termsAndPrivacyCheck, pushNotificationCheck, bluetoothPermission].allSatisfy({ $0.isChecked == true}) else {
			presentAlertWith(title: Copy.PermissionsValidationError.title, message: Copy.PermissionsValidationError.message)
			return false
		}
		return true
	}

	private func presentNotificationAccessAlert() {
		presentAlertWith(title: Copy.NotificationError.title, message: Copy.NotificationError.message)
	}

	private func presentBluetoothNotEnabledAlert() {
		presentAlertWith(title: Copy.BluetoothError.title, message: Copy.BluetoothError.message)
	}

	private func presentAlertWith(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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

extension PermissionCheckViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let alpha = (scrollView.contentSize.height - scrollView.frame.size.height) - scrollView.contentOffset.y
		footerView.layer.shadowColor = UIColor.black.withAlphaComponent(alpha).cgColor
	}
}
