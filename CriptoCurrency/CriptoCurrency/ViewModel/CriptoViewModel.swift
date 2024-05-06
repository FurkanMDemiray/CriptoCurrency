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

    func filterByRankDecresing() {
        criptoList = criptoList.sorted { $0.rank ?? 0 > $1.rank ?? 0 }
    }

    func filterByRankIncreasing() {
        criptoList = criptoList.sorted { $0.rank ?? 0 < $1.rank ?? 0 }
    }

    func filterByPriceDecresing() {
        criptoList = criptoList.sorted {
            guard let price1 = Double($0.price ?? ""), let price2 = Double($1.price ?? "") else { return false }
            return price1 > price2
        }
    }

    func filterByPriceIncreasing() {
        criptoList = criptoList.sorted {
            guard let price1 = Double($0.price ?? ""), let price2 = Double($1.price ?? "") else { return false }
            return price1 < price2
        }
    }

    func filterByMarketCapDecresing() {
        criptoList = criptoList.sorted {
            guard let marketCap1 = Double($0.marketCap ?? ""), let marketCap2 = Double($1.marketCap ?? "") else { return false }
            return marketCap1 > marketCap2
        }
    }

    func filterByMarketCapIncreasing() {
        criptoList = criptoList.sorted {
            guard let marketCap1 = Double($0.marketCap ?? ""), let marketCap2 = Double($1.marketCap ?? "") else { return false }
            return marketCap1 < marketCap2
        }
    }

    func filterByVolumeDecresing() {
        criptoList = criptoList.sorted {
            guard let the24HVolume1 = Double($0.the24HVolume ?? ""), let the24HVolume2 = Double($1.the24HVolume ?? "") else { return false }
            return the24HVolume1 > the24HVolume2
        }
    }

    func filterByVolumeIncreasing() {
        criptoList = criptoList.sorted {
            guard let the24HVolume1 = Double($0.the24HVolume ?? ""), let the24HVolume2 = Double($1.the24HVolume ?? "") else { return false }
            return the24HVolume1 < the24HVolume2
        }
    }

    func filterByChangeDecresing() {
        criptoList = criptoList.sorted {
            guard let change1 = Double($0.change ?? ""), let change2 = Double($1.change ?? "") else { return false }
            return change1 > change2
        }
    }

    func filterByChangeIncreasing() {
        criptoList = criptoList.sorted {
            guard let change1 = Double($0.change ?? ""), let change2 = Double($1.change ?? "") else { return false }
            return change1 < change2
        }
    }

    func filterByListedAtDecresing() {
        criptoList = criptoList.sorted { $0.listedAt ?? 0 > $1.listedAt ?? 0 }
    }

    func filterByListedAtIncreasing() {
        criptoList = criptoList.sorted { $0.listedAt ?? 0 < $1.listedAt ?? 0 }
    }
}
