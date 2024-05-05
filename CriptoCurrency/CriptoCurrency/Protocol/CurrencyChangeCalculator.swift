//
//  CurrencyChangeCalculator.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 5.05.2024.
//

import Foundation
import UIKit

protocol CurrencyChangeCalculator {
    func calculateChangeOfCurrencyInDollar(change: String, price: Double) -> (String, String)
    var formatter: NumberFormatter { get }
}
