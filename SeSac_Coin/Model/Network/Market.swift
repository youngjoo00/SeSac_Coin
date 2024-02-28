//
//  Market.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

struct Market: Decodable {
    let id: String
    let sysmbol: String
    let name: String
    let image: String
    let current_price: Int
    let price_change_percentage_24h: Double
    let low_24h: Int
    let high_24h: Int
    let ath: Int
    let ath_date: String
    let atl: Int
    let atl_date: String
    let sparkline_in_7d: [SparkLine]
}

struct SparkLine: Decodable {
    let price: [Double]
}
