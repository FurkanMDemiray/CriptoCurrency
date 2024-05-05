//
//  CurrencyChangeCalculatorExtension.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 5.05.2024.
//

import Foundation
import UIKit

extension CurrencyChangeCalculator {
    func calculateChangeOfCurrencyInDollar(change: String, price: Double) -> (String, String) {
        if change.contains("-") {
            let changeOfCurrencyInDollar = (price * 100) / (100 - Double(change)!)
            let changeAmount = price - changeOfCurrencyInDollar
            let changeOfCurrencyInDollarString = formatter.string(from: NSDecimalNumber(value: abs(changeAmount))) ?? ""
            return ("(\(change)%) (-\(changeOfCurrencyInDollarString))", "#F96A6A")
        }
        else {
            let changeOfCurrencyInDollar = (price * 100) / (100 + Double(change)!)
            let changeAmount = changeOfCurrencyInDollar - price
            let changeOfCurrencyInDollarString = formatter.string(from: NSDecimalNumber(value: abs(changeAmount))) ?? ""
            return ("+(\(change)%) (+\(changeOfCurrencyInDollarString))", "#3ED2A3")
        }
    }
}
