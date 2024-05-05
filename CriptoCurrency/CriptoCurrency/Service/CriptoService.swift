//
//  CriptoService.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 2.05.2024.
//

import Foundation
import Alamofire

class CriptoService {
    static let shared = CriptoService()

    private let url = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"

    func getCriptoCurrency(completion: @escaping (Result<CriptoCurrency, Error>) -> Void) {
        AF.request(url).responseDecodable(of: CriptoCurrency.self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let criptoCurrency):
                completion(.success(criptoCurrency))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
