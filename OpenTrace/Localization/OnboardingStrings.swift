//
//  OnboardingStrings.swift
//  OpenTrace
//
//  Created by Robbie Fraser on 14/04/2020.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import Foundation

extension DisplayStrings {

	enum Onboarding {

		static func enterOTPSent(mobileNumber: String) -> String {
			return "Onboarding.EnterOTPSent".localizedFormat(mobileNumber)
		}

		static let wrongNumber = "Onboarding.WrongNumber".localized

		static let resendCode = "Onboarding.ResendCode".localized

		static let invalidOTP = "Onboarding.InvalidOTP".localized

		static let wrongOTP = "Onboarding.WrongOTP".localized

		static func codeWillExpire(time: String) -> String {
			return "Onboarding.CodeWillExpire".localizedFormat(time)
		}

		static let codeHasExpired = "Onboarding.CodeHasExpired".localized

		enum Intro {
			static let header = "Onboarding.Intro.header".localized
			static let primaryBody = "Onboarding.Intro.primaryBody".localized
			static let footerButtonTitle = "Onboarding.Intro.footerButtonTitle".localized
		}

		enum PermissionCheck {
			static let header = "Onboarding.PermissionCheck.header".localized
			static let body = "Onboarding.PermissionCheck.body".localized
			static let termsAndPrivacyPolicyText = "Onboarding.PermissionCheck.termsAndPrivacyPolicyText".localized
			static let privacyPolicyHighlightedText = "Onboarding.PermissionCheck.privacyPolicyHighlightedText".localized
			static let termsHighlightedText = "Onboarding.PermissionCheck.termsHighlightedText".localized
			static let noticationText = "Onboarding.PermissionCheck.noticationText".localized
			static let bluetoothText = "Onboarding.PermissionCheck.bluetoothText".localized
			static let footerButtonTitle = "Onboarding.PermissionCheck.footerButtonTitle".localized

			enum PermissionsValidationError {
				static let title = "Onboarding.PermissionCheck.PermissionsValidationError.title".localized
				static let message = "Onboarding.PermissionCheck.PermissionsValidationError.message".localized
			}

			enum NotificationError {
				static let title = "Onboarding.PermissionCheck.NotificationError.title".localized
				static let message = "Onboarding.PermissionCheck.NotificationError.message".localized
			}

			enum BluetoothError {
				static let title = "Onboarding.PermissionCheck.BluetoothError.title".localized
				static let message = "Onboarding.PermissionCheck.BluetoothError.message".localized
			}
		}

		enum Constent {
			static let header = "Onboarding.Constent.header".localized
			static let primaryBody = "Onboarding.Constent.primaryBody".localized
			static let secondaryBody = "Onboarding.Constent.secondaryBody".localized
			static let preceedingPrivacyButtonTitle = "Onboarding.Constent.preceedingPrivacyButtonTitle".localized
			static let privacyButtonTitle = "Onboarding.Constent.privacyButtonTitle".localized
			static let footerButtonTitle = "Onboarding.Constent.footerButtonTitle".localized
		}

		enum Permissions {
			static let header = "Onboarding.Permissions.header".localized
			static let primaryBody = "Onboarding.Permissions.primaryBody".localized
			static let secondaryBody = "Onboarding.Permissions.secondaryBody".localized
			static let tertiaryBody = "Onboarding.Permissions.tertiaryBody".localized
			static let footerButtonTitle = "Onboarding.Permissions.footerButtonTitle".localized
		}

		enum TurnOnBluetooth {
			static let header = "Onboarding.TurnOnBluetooth.header".localized
			static let primaryBody = "Onboarding.TurnOnBluetooth.primaryBody".localized
			static let secondaryBody = "Onboarding.TurnOnBluetooth.secondaryBody".localized
			static let footerButtonTitle = "Onboarding.TurnOnBluetooth.footerButtonTitle".localized
		}

		enum PermissionsComplete {
			static let header = "Onboarding.PermissionsComplete.header".localized
			static let body = "Onboarding.PermissionsComplete.body".localized
			static let footerButtonTitle = "Onboarding.PermissionsComplete.footerButtonTitle".localized
		}

		enum PogoInstructions {
			static let header = "Onboarding.PogoInstructions.header".localized
			static let primaryBody = "Onboarding.PogoInstructions.primaryBody".localized
			static let secondaryBody = "Onboarding.PogoInstructions.secondaryBody".localized
			static let faceDown = "Onboarding.PogoInstructions.faceDown".localized
			static let upsideDown = "Onboarding.PogoInstructions.upsideDown".localized
			static let footerText = "Onboarding.PogoInstructions.footerText".localized
			static let footerButtonTitle = "Onboarding.PogoInstructions.footerButtonTitle".localized
		}
	}
}
