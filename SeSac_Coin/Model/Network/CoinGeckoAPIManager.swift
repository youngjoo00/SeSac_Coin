//
//  CoinAPIManager.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import Alamofire

class CoinGeckoAPIManager {
    
    static let shared = CoinGeckoAPIManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(type: T.Type, api: CoinGeckoAPI, completionHandler: @escaping (T?, AFError?) -> Void) {
        
        AF.request(api.endPoint, parameters: api.parameter).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data, nil)
            case .failure(let fail):
                completionHandler(nil, fail)
                print(fail)
            }
        }
    }
    
//    func callRequest<T: Decodable>(type: T.Type ,api: TMDBAPI, completionHandler: @escaping (T?, ErrorStatus?) -> Void) {
//            
//            AF.request(api.endpoint,
//                       parameters: api.parameter,
//                       encoding: URLEncoding(destination: .queryString),
//                       headers: api.header).responseDecodable(of: T.self) { response in
//                switch response.result {
//                case .success(let data):
//                    completionHandler(data, nil)
//                case .failure(let fail):
//                    print(fail)
//                    completionHandler(nil, .failedRequest)
//                }
//            }
//        }

}
