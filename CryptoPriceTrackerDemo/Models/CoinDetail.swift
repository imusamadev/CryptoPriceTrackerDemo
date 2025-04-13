//
//  CoinDetail.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//


struct CoinDetail: Codable {
    let id: String
    let symbol: String
    let name: String
    let image: CoinImage
    let marketCapRank: Int?
    let marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case image
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
    }
}

struct CoinImage: Codable {
    let thumb: String
    let small: String
    let large: String
}

struct MarketData: Codable {
    let currentPrice: [String: Double]
    let marketCap: [String: Double]
    let totalVolume: [String: Double]
    let priceChangePercentage24H: Double?

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}

