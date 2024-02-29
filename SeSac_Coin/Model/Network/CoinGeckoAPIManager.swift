//
//  CoinAPIManager.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import Alamofire

final class CoinGeckoAPIManager {
    
    static let shared = CoinGeckoAPIManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(type: T.Type, api: CoinGeckoAPI, completionHandler: @escaping (T?, AFError?) -> Void) {
        AF.request(api.endPoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString))
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data, nil)
            case .failure(let fail):
                completionHandler(nil, fail)
            }
        }
    }

}
