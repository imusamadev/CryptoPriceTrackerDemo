//
//  CryptoService.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import Foundation
import Alamofire
import RxSwift

class CryptoService {
    func fetchCryptoCurrencies() -> Observable<[CryptoCurrency]> {
        let url = "https://api.coingecko.com/api/v3/coins/markets"
        let parameters: Parameters = [
            "vs_currency": "usd",
            "order": "market_cap_desc",
            "per_page": 100,
            "page": 1,
            "sparkline": true
        ]
        
        return Observable.create { observer in
            let request = AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: [CryptoCurrency].self) { response in
                    switch response.result {
                    case .success(let currencies):
                        observer.onNext(currencies)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
