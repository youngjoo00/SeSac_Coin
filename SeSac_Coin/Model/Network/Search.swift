//
//  SearchCoinModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

struct Search: Decodable {
    let coins: [Coin]
    
}

struct Coin: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
}
