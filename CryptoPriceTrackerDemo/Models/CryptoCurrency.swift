//
//  CryptoCurrency.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import Foundation

struct CryptoCurrency: Decodable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double
    let totalVolume: Double
    let priceChangePercentage24h: Double

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}
