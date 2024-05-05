//
//  CriptoViewModel.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import Foundation

final class CriptoViewModel {

    var criptoCurrency: CriptoCurrency?
    var criptoList = [Coin]()

    func getCriptoCurrency(completion: @escaping (Result<CriptoCurrency, Error>) -> Void) {
        CriptoService.shared.getCriptoCurrency { result in
            switch result {
            case .success(let criptoCurrency):
                self.criptoCurrency = criptoCurrency
                completion(.success(criptoCurrency))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
