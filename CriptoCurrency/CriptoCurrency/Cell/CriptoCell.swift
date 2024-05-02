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
        currencyShortName.text = coins.symbol
        currencyFullName.text = coins.name
        if let price = coins.price {
            let priceDouble = Double(price)
            currencyValue.text = String(format: "$%.5f", priceDouble!)
        }
        changeOfCurrency.text = "\(coins.change ?? "")"

        // get .svg image from url
        if let imageUrl = coins.iconURL {
            currencyImage.kf.setImage(with: URL(string: imageUrl)) { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        }
    }

}
