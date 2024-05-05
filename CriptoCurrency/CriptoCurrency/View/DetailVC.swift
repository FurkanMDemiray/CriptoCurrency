//
//  DetailVC.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 4.05.2024.
//

import UIKit

class DetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addLabelToNavigation()
        configureBackButton()
    }

    private func addLabelToNavigation() {
        navigationItem.title = "BTC"
        navigationItem.prompt = "Bitcoin"

    }

    private func configureBackButton() {

    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}
