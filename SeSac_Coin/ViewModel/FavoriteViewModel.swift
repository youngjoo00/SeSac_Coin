//
//  FavoriteViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import Foundation

final class FavoriteViewModel {
    
    let repository = CoinRepository()
    
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    var inputDidSelectItemAtCoinID: Observable<String?> = Observable(nil)
    
    var outputList: Observable<[Market]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputTransition: Observable<String?> = Observable(nil)
    var isLoding = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidAppearTrigger.bind { _ in
            self.getFavoriteList()
        }
        
        inputDidSelectItemAtCoinID.bind { id in
            guard let id else { return }
            self.outputTransition.value = id
        }
    }
    
}

extension FavoriteViewModel {
    
    private func getFavoriteList() {
        isLoding.value = true
        
        let id = self.repository.fetchCoinID()
        if id.isEmpty {
            self.outputList.value = []
            isLoding.value = false
        } else {
            CoinGeckoAPIManager.shared.callRequest(type: [Market].self, api: .favorite(id: id)) { result in
                switch result {
                case .success(let data):
                    self.outputList.value = data
                case .failure(let failure):
                    self.outputNetworkErrorMessage.value = failure.rawValue
                }
            }
            isLoding.value = false
        }
    }

}
