//
//  CheckboxButton.swift
//  OpenTrace
//
//  Created by Robbie Fraser on 16/04/2020.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import UIKit

final class CheckboxButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	private func setup() {
		cornerRadius = 4
		layer.borderWidth = 2
		layer.borderColor = UIColor.black.cgColor
		setImage(UIImage(named: "check"), for: .selected)
		imageView?.translatesAutoresizingMaskIntoConstraints = false
		if let imageView = imageView {
			NSLayoutConstraint.activate([
				imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
				imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
				imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
				imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
			])
		}
	}
}
