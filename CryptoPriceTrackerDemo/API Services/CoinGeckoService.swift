//
//  CoinGeckoService.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import Foundation
import RxSwift

class CoinGeckoService {
    func fetchCoinDetail(by id: String) -> Single<CoinDetail> {
        return Single.create { single in
            guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)") else {
                single(.failure(NSError(domain: "Invalid URL", code: -1)))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data else {
                    single(.failure(NSError(domain: "No data", code: -1)))
                    return
                }
                
                do {
                    let coinDetail = try JSONDecoder().decode(CoinDetail.self, from: data)
                    single(.success(coinDetail))
                } catch {
                    single(.failure(error))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

extension CoinGeckoService {
    func fetchHistoricalPrices(for id: String, days: Int = 7) -> Observable<[HistoricalPrice]> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)/market_chart?vs_currency=usd&days=\(days)") else {
            return Observable.just([])
        }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data -> [HistoricalPrice] in
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let prices = json["prices"] as? [[Double]] else {
                    return []
                }
                
                return prices.compactMap { entry in
                    guard entry.count == 2 else { return nil }
                    let timestamp = entry[0] / 1000 // ms to seconds
                    let date = Date(timeIntervalSince1970: timestamp)
                    return HistoricalPrice(date: date, price: entry[1])
                }
            }
    }
}
