//
//  SearchCoinModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

struct Search: Decodable {
    let coins: [Serach_Coin]
}

struct Serach_Coin: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    var favorite: Bool
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case symbol
        case thumb
        case favorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.thumb = try container.decode(String.self, forKey: .thumb)
        self.favorite = false
    }
}
