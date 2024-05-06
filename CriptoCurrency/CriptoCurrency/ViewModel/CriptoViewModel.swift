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
        CriptoService.shared.getCriptoCurrency { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let criptoCurrency):
                self.criptoCurrency = criptoCurrency
                completion(.success(criptoCurrency))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func filterByPriceDecresing() {
        criptoList = criptoList.sorted { $0.price ?? "" > $1.price ?? "" }
    }

    func filterByPriceIncreasing() {
        criptoList = criptoList.sorted { $0.price ?? "" < $1.price ?? "" }
    }

    func filterByMarketCapDecresing() {
        criptoList = criptoList.sorted { $0.marketCap ?? "" > $1.marketCap ?? "" }
    }

    func filterByMarketCapIncreasing() {
        criptoList = criptoList.sorted { $0.marketCap ?? "" < $1.marketCap ?? "" }
    }

    func filterByVolumeDecresing() {
        criptoList = criptoList.sorted { $0.the24HVolume ?? "" > $1.the24HVolume ?? "" }
    }

    func filterByVolumeIncreasing() {
        criptoList = criptoList.sorted { $0.the24HVolume ?? "" < $1.the24HVolume ?? "" }
    }

    func filterByChangeDecresing() {
        criptoList = criptoList.sorted { $0.change ?? "" > $1.change ?? "" }
    }

    func filterByChangeIncreasing() {
        criptoList = criptoList.sorted { $0.change ?? "" < $1.change ?? "" }
    }

    func filterByListedAtDecresing() {
        criptoList = criptoList.sorted { $0.listedAt ?? 0 > $1.listedAt ?? 0 }
        print(criptoList)
    }

    func filterByListedAtIncreasing() {
        criptoList = criptoList.sorted { $0.listedAt ?? 0 < $1.listedAt ?? 0 }
    }
}
