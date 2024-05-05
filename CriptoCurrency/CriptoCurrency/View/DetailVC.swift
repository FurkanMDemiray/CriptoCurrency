//
//  DetailVC.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 4.05.2024.
//

import UIKit
import Charts

class DetailVC: UIViewController {

    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyVİew: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var changeOfCurrencyLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!

    lazy var selectedCoin: Coin? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        setLabels()
    }

    private func configureView() {
        currencyVİew.layer.cornerRadius = 10
        currencyVİew.layer.borderWidth = 1
        currencyVİew.layer.borderColor = UIColor.lightGray.cgColor
        currencyVİew.layer.shadowColor = UIColor.black.cgColor
        currencyVİew.layer.shadowOffset = CGSize(width: 0, height: 1)
        currencyVİew.layer.shadowOpacity = 0.2
        currencyVİew.layer.shadowRadius = 1
    }

    private func setLabels() {
        shortNameLabel.text = selectedCoin?.symbol
        nameLabel.text = selectedCoin?.name
        if let price = selectedCoin?.price {
            priceLabel.text = formatter.string(from: NSDecimalNumber(string: price))
        }
        //highLabel.text = coin?.high
        //lowLabel.text = coin?.low
        if let price = selectedCoin?.price {
            let priceDouble = Double(price)
            priceLabel.text = formatter.string(from: NSDecimalNumber(value: priceDouble ?? 0.0))
            if let change = selectedCoin?.change {
                let (changeOfCurrencyInDollar, color) = calculateChangeOfCurrencyInDollar(change: change, price: priceDouble ?? 0.0)
                changeOfCurrencyLabel.text = changeOfCurrencyInDollar
                changeOfCurrencyLabel.textColor = colorFromHex(hex: color)
            }
        }
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

