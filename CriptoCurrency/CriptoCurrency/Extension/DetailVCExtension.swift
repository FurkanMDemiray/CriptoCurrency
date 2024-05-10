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

    var oneDigitFormatter: NumberFormatter {
        return NumberFormatter.oneDigitCurrencyFormatter()
    }

    func isSingleDigitLeftOfDecimal(_ number: Double) -> Bool {
        let integerPart = Int(number)
        let absoluteIntegerPart = abs(integerPart)
        return absoluteIntegerPart >= 0 && absoluteIntegerPart <= 9
    }
}
