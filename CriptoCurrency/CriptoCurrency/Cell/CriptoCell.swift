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

    func configureCell(with coins: Coin) {
        currencyFullName.textColor = colorFromHex(hex: coins.color ?? "0E1959")
        if let shortName = coins.symbol {
            currencyShortName.text = shortName
        }
        if let fullName = coins.name {
            currencyFullName.text = fullName
        }
        if let price = coins.price {
            let priceDouble = Double(price)
            currencyValue.text = formatter.string(from: NSDecimalNumber(value: priceDouble ?? 0.0))
            if let change = coins.change {
                let (changeOfCurrencyInDollar, color) = calculateChangeOfCurrencyInDollar(change: change, price: priceDouble ?? 0.0)
                changeOfCurrency.text = changeOfCurrencyInDollar
                changeOfCurrency.textColor = colorFromHex(hex: color)
            }
        }
        if var iconURLString = coins.iconURL, var iconURL = URL(string: iconURLString) {
            currencyImage.kf.indicatorType = .activity
            if iconURLString.contains(".svg") {
                iconURLString = iconURLString.replacingOccurrences(of: ".svg", with: ".png")
                iconURL = URL(string: iconURLString)!
                currencyImage.kf.setImage(with: iconURL)
            }
            else {
                currencyImage.kf.setImage(with: iconURL)
            }
        }
    }
}
