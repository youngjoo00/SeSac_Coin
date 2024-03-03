//
//  Trend.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/1/24.
//

struct Trend: Decodable {
    let coins: [Trend_Item]
    let nfts: [Trend_NFT]
}

struct Trend_Item: Decodable {
    let item: Trend_Item_Coin
}

struct Trend_Item_Coin: Decodable {
    let id: String
    let name: String
    let symbol: String
    let small: String
    let rank: Int
    let priceData: Trend_Item_Coin_Price
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case small
        case priceData = "data"
        case rank = "market_cap_rank"
    }
}

struct Trend_Item_Coin_Price: Decodable {
    let price: String
    let price_change_percentage_24h: Trend_Item_Coin_Price_KRW
}

struct Trend_Item_Coin_Price_KRW: Decodable {
    let krw: Double
}

struct Trend_NFT: Decodable {
    let name: String
    let symbol: String
    let thumb: String
    let priceData: Trend_NFT_Price
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case thumb
        case priceData = "data"
    }

}

struct Trend_NFT_Price: Decodable {
    let floor_price: String
    let floor_price_in_usd_24h_percentage_change: String
}
