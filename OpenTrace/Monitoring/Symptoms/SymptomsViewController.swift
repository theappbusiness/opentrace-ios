//
//  SymptomsViewController.swift
//  OpenTrace
//
//  Created by Sam Dods on 15/04/2020.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import UIKit

class SymptomsViewController: UIViewController {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var closingStatement: UILabel!
    @IBOutlet private var finishButton: UIButton!
    @IBOutlet private var symptomsList: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typealias Copy = DisplayStrings.Monitoring.TrackSymptoms
        titleLabel.text = Copy.title
        subtitleLabel.text = Copy.subtitle
        closingStatement.text = Copy.closingStatement
        finishButton.setTitle(Copy.submit, for: .normal)

        // TODO: this will come from the backend, or at least from hardcoded JSON
        [
            "Do you feel like you have a cold?",
            "Do you have a temperature over 38º?",
            "Have you had a temperature over 38º for more than one day?",
            "Do you have a persistent cough?",
            "Are you experiencing unusual fatigue?",
        ].forEach { question in
            let viewModel = BinaryQuestionControl.Model(question: question, answerTrue: "Yes", answerFalse: "No")
            let view = BinaryQuestionControl.loadFromNib()
            view.configure(with: viewModel)
            symptomsList.addArrangedSubview(view)
        }
    }

    @IBAction private func didTapFinish(_ sender: Any) {
        showContactForm()
        return
        let symptoms = symptomsList.arrangedSubviews.compactMap { $0 as? BinaryQuestionControl }
        let unanswered = symptoms.filter { $0.answer == nil }
        guard unanswered.count == 0 else {
            presentErrorIncomplete()
            return
        }
        checkScore()
    }
    
    private func presentErrorIncomplete() {
        // TODO: localise
        let alert = UIAlertController(title: "Incomplete", message: "You need to answer all questions.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func checkScore() {
        let score = 100
        switch score {
        case 200...:
            showContactForm()
        case 100...200:
            showAdvice()
        default:
            showAdvice()
        }
    }
        
    private func showAdvice() {
        let adviceController = AdviceViewController()
        navigationController?.pushViewController(adviceController, animated: true)
    }
        
    private func showContactForm() {
        let contactController = ContactFormViewController()
        navigationController?.pushViewController(contactController, animated: true)
    }
}
