//
//  FavoriteViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import Foundation

final class FavoriteViewModel {
    
    let repository = CoinRepository()
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    var outputList: Observable<[Market]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { _ in
            let id = self.repository.fetchCoinID()
            guard !id.isEmpty else { return }
            
            self.fetchFavoriteCoinList(id) { data in
                self.outputList.value = data
            }
        }
    }
    
    private func fetchFavoriteCoinList(_ id: [String], completionHandler: @escaping ([Market]) -> Void) {
        CoinGeckoAPIManager.shared.callRequest(type: [Market].self, api: .favorite(id: id)) { data, error in
            if let data {
                completionHandler(data)
            } else if let error {
                print(error)
            }
        }
    }
}
