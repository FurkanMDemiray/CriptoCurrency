//
//  CurrencyFormatter.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 5.05.2024.
//

import Foundation

extension NumberFormatter {
    static func currencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = "$"
        return formatter
    }

    static func oneDigitCurrencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 5
        formatter.currencySymbol = "$"
        return formatter
    }
}
