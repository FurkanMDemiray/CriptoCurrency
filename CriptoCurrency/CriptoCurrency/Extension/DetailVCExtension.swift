//
//  DetailVCExtension.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 5.05.2024.
//

import Foundation

extension DetailVC: StringToHexCode, CurrencyChangeCalculator {
    var formatter: NumberFormatter {
        return NumberFormatter.currencyFormatter()
    }
}
