//
//  FavoriteViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import Foundation

class FavoriteViewModel {
    
    let repository = CoinRepository()
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputList: Observable<[FavoriteCoin]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            let data = self.repository.fetchItem()

            //self.fetchFavoriteCoinList(<#T##parameter: [String]##[String]#>)
        }
    }
    
    private func fetchFavoriteCoinList(_ parameter: [String]) {
        
    }
}
