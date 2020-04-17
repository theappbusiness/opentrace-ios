//
//  InfectedNotificationViewController.swift
//  OpenTrace
//
//  Created by Neil Horton on 17/04/2020.
//Copyright © 2020 OpenTrace. All rights reserved.
//

import UIKit

final class InfectedNotificationViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var primaryCTA: UIButton!
    
    private typealias Copy = DisplayStrings.InAppMessages.InfectedContactNotification
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setCopy() {
        titleLabel.text = Copy.title
        subtitleLabel.text = Copy.subHeading
        primaryCTA.setTitle(Copy.primaryCTA, for: .normal)
    }
    
    @IBAction private func primaryCTATapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
