//
//  CryptoService.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import Foundation
import RxSwift

class CryptoService {
    func fetchCryptoCurrencies() -> Observable<[CryptoCurrency]> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true") else {
            return Observable.just([])
        }

        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                let decoder = JSONDecoder()
                return try decoder.decode([CryptoCurrency].self, from: data)
            }
            .catchAndReturn([])
    }
}
