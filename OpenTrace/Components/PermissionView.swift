//
//  PermissionView.swift
//  OpenTrace
//
//  Created by Robbie Fraser on 17/04/2020.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import UIKit

final class PermissionView: UIView {

	private let checkBoxButton = CheckboxButton()
	private let label = UILabel()
	private var checkButtonAction: ((Bool) -> Bool)?

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

	func configure(with text: String, onCheck checkAction: @escaping (Bool) -> Bool) {
		label.text = text
		checkButtonAction = checkAction
	}

	@objc private func checkButtonTapped() {
		guard let isSelected = checkButtonAction?(isChecked) else { return }
		checkBoxButton.isSelected = isSelected
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
