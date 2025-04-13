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
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        // Print raw JSON response
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw JSON response:\n\(jsonString)")
                        }
                        
                        do {
                            let decoded = try JSONDecoder().decode([CryptoCurrency].self, from: data)
                            observer.onNext(decoded)
                            observer.onCompleted()
                        } catch {
                            print("Decoding error: \(error)")
                            observer.onError(error)
                        }
                    case .failure(let error):
                        print("Request error: \(error)")
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
