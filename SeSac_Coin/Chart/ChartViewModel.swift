//
//  ChartViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import Foundation

class ChartViewModel {
    
    let repository = CoinRepository()
    
    let inputCoinID: Observable<String> = Observable("")
    
    let outputList: Observable<[Market]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputCoinID.bind { value in
            let id = value
            guard !id.isEmpty else { return }
            
            self.fetchFavoriteCoinList(id) { data in
                self.outputList.value = data
            }
        }
    }
    
    private func fetchFavoriteCoinList(_ id: String, completionHandler: @escaping ([Market]) -> Void) {
        CoinGeckoAPIManager.shared.callRequest(type: [Market].self, api: .market(id: id)) { data, error in
            if let data {
                completionHandler(data)
            } else if let error {
                print(error)
            }
        }
    }
    
}
