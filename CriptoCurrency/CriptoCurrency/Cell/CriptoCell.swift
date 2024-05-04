//
//  CriptoCell.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import UIKit
import Kingfisher

class CriptoCell: UITableViewCell {

    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyShortName: UILabel!
    @IBOutlet weak var currencyFullName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var changeOfCurrency: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        configureCurrencyView()
    }

    private func configureCurrencyView() {
        currencyView.layer.cornerRadius = 10
        currencyView.layer.borderWidth = 1
        currencyView.layer.borderColor = UIColor.lightGray.cgColor
        currencyView.layer.shadowColor = UIColor.black.cgColor
        currencyView.layer.shadowOffset = CGSize(width: 0, height: 1)
        currencyView.layer.shadowOpacity = 0.2
        currencyView.layer.shadowRadius = 1
    }

    private func calculateChangeOfCurrencyInDollar(change: String, price: Double) -> (String, UIColor) {
        if change.contains("-") {
            let changeOfCurrencyInDollar = (price * 100) / (100 - Double(change)!)
            let changeAmount = price - changeOfCurrencyInDollar
            let changeOfCurrencyInDollarString = String(format: "%.3f", abs(changeAmount))
            return ("(\(change)%) (-$\(changeOfCurrencyInDollarString))", .systemRed)
        }
        else {
            let changeOfCurrencyInDollar = (price * 100) / (100 + Double(change)!)
            let changeAmount = changeOfCurrencyInDollar - price
            let changeOfCurrencyInDollarString = String(format: "%.3f", abs(changeAmount))
            return ("+(\(change)%) (+$\(changeOfCurrencyInDollarString)", .systemGreen)
        }
    }

    func configureCell(with coins: Coin) {
        if let price = coins.price {
            let priceDouble = Double(price)
            currencyValue.text = String(format: "$%.5f", priceDouble!)
            if let change = coins.change {
                let (changeOfCurrencyInDollar, color) = calculateChangeOfCurrencyInDollar(change: change, price: priceDouble ?? 0.0)
                changeOfCurrency.text = String(format: "%@", changeOfCurrencyInDollar)
                changeOfCurrency.textColor = color
            }
        }
        if let color = coins.color {
            currencyFullName.textColor = colorFromHex(hex: color)
        }

        currencyShortName.text = coins.symbol
        currencyFullName.text = coins.name


        if var iconURLString = coins.iconURL, var iconURL = URL(string: iconURLString) {
            if iconURLString.contains("svg") {
                iconURLString = iconURLString.replacingOccurrences(of: "svg", with: "png")
                iconURL = URL(string: iconURLString)!
                currencyImage.kf.indicatorType = .activity
                currencyImage.kf.setImage(with: iconURL)
            }
            else {
                currencyImage.kf.indicatorType = .activity
                currencyImage.kf.setImage(with: iconURL)
            }
        }
    }
}
