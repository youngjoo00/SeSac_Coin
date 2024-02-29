//
//  CoinAPI.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import Alamofire
import Foundation

enum CoinGeckoAPI {
    case trending
    case search(query: String)
    case market(id: String)
    case favorite(id: [String])
    
    static let baseURL = "https://api.coingecko.com/api/v3/"
    
    var endPoint: URL {
        switch self {
        case .trending:
            return URL(string: "")!
        case .search(let query):
            return URL(string: CoinGeckoAPI.baseURL + "search?query=\(query)")!
        case .market:
            return URL(string: CoinGeckoAPI.baseURL + "coins/markets")!
        case .favorite:
            return URL(string: CoinGeckoAPI.baseURL + "coins/markets")!
        }
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            return [:]
        case .search:
            return [:]
        case .market(let id):
            return ["vs_currency": "krw", "ids": id, "sparkline": "true"]
        case .favorite(let id):
            let ids = id.joined(separator: ",")
            return ["vs_currency": "krw", "ids": ids]
        }
    }
}
