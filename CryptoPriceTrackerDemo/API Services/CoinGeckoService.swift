//
//  CoinGeckoService.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import Foundation
import RxSwift
import Alamofire

class CoinGeckoService {
    
    func fetchCoinDetail(by id: String) -> Single<CoinDetail> {
        return Single.create { single in
            let url = "https://api.coingecko.com/api/v3/coins/\(id)"
            
            let request = AF.request(url)
                .validate()
                .responseDecodable(of: CoinDetail.self) { response in
                    switch response.result {
                    case .success(let coinDetail):
                        single(.success(coinDetail))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchHistoricalPrices(for id: String, days: Int = 7) -> Observable<[HistoricalPrice]> {
        let url = "https://api.coingecko.com/api/v3/coins/\(id)/market_chart"
        let parameters: Parameters = [
            "vs_currency": "usd",
            "days": days
        ]
        
        return Observable.create { observer in
            let request = AF.request(url, parameters: parameters)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard
                            let json = value as? [String: Any],
                            let prices = json["prices"] as? [[Double]]
                        else {
                            observer.onNext([])
                            observer.onCompleted()
                            return
                        }
                        
                        let historicalPrices = prices.compactMap { entry -> HistoricalPrice? in
                            guard entry.count == 2 else { return nil }
                            let timestamp = entry[0] / 1000
                            let date = Date(timeIntervalSince1970: timestamp)
                            return HistoricalPrice(date: date, price: entry[1])
                        }
                        
                        observer.onNext(historicalPrices)
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
