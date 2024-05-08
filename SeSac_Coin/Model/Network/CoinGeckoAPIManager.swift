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
    
    func callRequest<T: Decodable>(type: T.Type, api: CoinGeckoAPI, completionHandler: @escaping (_ result: Result<T, ErrorStatus>) -> Void) {
        AF.request(api.endPoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString))
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let fail):
                switch fail {
                case .responseValidationFailed:
                    print("응답코드 에러")
                    completionHandler(.failure(.invalidResponse))
                case .responseSerializationFailed(let reason):
                    if case .inputDataNilOrZeroLength = reason {
                        print("데이터 없음")
                        completionHandler(.failure(.noData))
                    } else {
                        print("디코딩 실패")
                        print(fail)
                        completionHandler(.failure(.invalidData))
                    }
                default:
                    print("통신 에러")
                    completionHandler(.failure(.failedRequest))
                }
            }
        }
    }
    
    // 알라모파이어 통신은 이렇게 하네??
    func callAsyncAwaitRequest<T: Decodable> (type: T.Type, api: CoinGeckoAPI) async throws -> T {
        do {
            let request = AF.request(api.endPoint,
                                     parameters: api.parameter,
                                     encoding: URLEncoding(destination: .queryString))
            
            let response = try await request.validate(statusCode: 200..<300).serializingDecodable(T.self).value
            
            return response
        } catch {
            if let afError = error.asAFError {
                switch afError {
                case .responseValidationFailed:
                    throw ErrorStatus.failedRequest
                case .responseSerializationFailed(let reason):
                    if case .inputDataNilOrZeroLength = reason {
                        throw ErrorStatus.noData
                    } else {
                        throw ErrorStatus.invalidData
                    }
                default:
                    throw ErrorStatus.failedRequest
                }
            }
            throw ErrorStatus.failedRequest
        }
    }
    
}
