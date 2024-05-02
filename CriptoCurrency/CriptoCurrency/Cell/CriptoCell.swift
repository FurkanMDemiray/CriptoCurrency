//
//  CriptoCell.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import UIKit

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
        // shadow
        currencyView.layer.shadowColor = UIColor.black.cgColor
        currencyView.layer.shadowOffset = CGSize(width: 0, height: 1)
        currencyView.layer.shadowOpacity = 0.2
        currencyView.layer.shadowRadius = 1
    }

    func configureCell(cripto: CriptoCurrency) {

        /*currencyImage.image = UIImage(named: cripto.image)
        currencyShortName.text = cripto.shortName
        currencyFullName.text = cripto.fullName
        currencyValue.text = String(cripto.value)
        changeOfCurrency.text = cripto.change

        if cripto.change.contains("-") {
            changeOfCurrency.textColor = .red
        } else {
            changeOfCurrency.textColor = .green
        }*/
    }

}
