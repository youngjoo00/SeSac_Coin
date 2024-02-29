//
//  Market.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

struct Market: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double
    let low_24h: Double
    let high_24h: Double
    let ath: Double
    let ath_date: String
    let atl: Double
    let atl_date: String
    let last_updated: String
    let sparkline_in_7d: SparkLine?
    
    enum CodingKeys: CodingKey {
        case id
        case symbol
        case name
        case image
        case current_price
        case price_change_percentage_24h
        case low_24h
        case high_24h
        case ath
        case ath_date
        case atl
        case atl_date
        case last_updated
        case sparkline_in_7d
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.current_price = try container.decodeIfPresent(Double.self, forKey: .current_price) ?? 0
        self.price_change_percentage_24h = try container.decodeIfPresent(Double.self, forKey: .price_change_percentage_24h) ?? 0
        self.low_24h = try container.decodeIfPresent(Double.self, forKey: .low_24h) ?? 0
        self.high_24h = try container.decodeIfPresent(Double.self, forKey: .high_24h) ?? 0
        self.ath = try container.decodeIfPresent(Double.self, forKey: .ath) ?? 0
        self.ath_date = try container.decodeIfPresent(String.self, forKey: .ath_date) ?? ""
        self.atl = try container.decodeIfPresent(Double.self, forKey: .atl) ?? 0
        self.atl_date = try container.decodeIfPresent(String.self, forKey: .atl_date) ?? ""
        self.last_updated = try container.decodeIfPresent(String.self, forKey: .last_updated) ?? ""
        self.sparkline_in_7d = try container.decodeIfPresent(SparkLine.self, forKey: .sparkline_in_7d)
    }
}

struct SparkLine: Decodable {
    let price: [Double]
}
