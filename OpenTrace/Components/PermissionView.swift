//
//  PermissionView.swift
//  OpenTrace
//
//  Created by Robbie Fraser on 17/04/2020.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import UIKit
import SafariServices

protocol PermissionViewDelegate: AnyObject {
	func didTapLink(url: URL)
}

final class PermissionView: UIView {

	private let checkBoxButton = CheckboxButton()
	private let textView = UITextView()
	private var checkButtonAction: (() -> Void)?

	private weak var delegate: PermissionViewDelegate?

	var isChecked: Bool {
		get {
			return checkBoxButton.isSelected
		}
		set {
			checkBoxButton.isSelected = newValue
		}
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
		[checkBoxButton, textView].forEach { view in
			addSubview(view)
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		textView.textAlignment = .left
		textView.isScrollEnabled = false
		textView.isEditable = false
		textView.delegate = self
		textView.textContainer.lineFragmentPadding = 0
		textView.textContainerInset = .zero
		setupConstraints()
		checkBoxButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchDown)
	}

	func configure(with text: String, linkText: [LinkModel]? = nil, delegate: PermissionViewDelegate, onCheck checkAction: @escaping () -> Void) {
		self.delegate = delegate
		checkButtonAction = checkAction
		let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)] )
		setupLinks(linkText: linkText, text: text, attributedString: attributedString)
		textView.attributedText = attributedString
	}

	func setupLinks(linkText: [LinkModel]?, text: String, attributedString: NSMutableAttributedString) {
		linkText?.forEach { linkText in
			let linkRange = NSString(string: text).range(of: linkText.text, options: .caseInsensitive)
			attributedString.addAttribute(.link, value: linkText.link, range: linkRange)
			attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
											NSAttributedString.Key.foregroundColor: UIColor.black], range: linkRange)
		}
		textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
	}

	@objc private func checkButtonTapped() {
		checkButtonAction?()
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			checkBoxButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			checkBoxButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
			checkBoxButton.heightAnchor.constraint(equalToConstant: 24),
			checkBoxButton.widthAnchor.constraint(equalTo: checkBoxButton.heightAnchor),

			textView.topAnchor.constraint(equalTo: checkBoxButton.topAnchor),
			textView.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 18),
			textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -37)
		])
	}
}

extension PermissionView: UITextViewDelegate {
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		delegate?.didTapLink(url: URL)
		return false
	}
}

extension PermissionView {

	struct LinkModel {
		let text: String
		let link: String
	}
}
