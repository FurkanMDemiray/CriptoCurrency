//
//  CriptoCurrency.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import Foundation


struct CriptoCurrency: Codable {
    let shortName: String?
    let fullName: String?
    let value: Double?
    let change: Double?
    let imageUrl: String?
}
