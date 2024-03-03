//
//  SearchViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import Foundation

final class SearchViewModel {
    
    private let repository = CoinRepository()
    
    var inputSearchBarText: Observable<String?> = Observable(nil)
    var inputFavoriteBtnTapped: Observable<String?> = Observable(nil)
    
    var outputSearchList: Observable<[Serach_Coin]> = Observable([])
    var outputFavoriteBtnReslut: Observable<String?> = Observable(nil)
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchBarText.bind { value in
            guard let value else { return }
            self.getSearchList(value)
        }
        
        inputFavoriteBtnTapped.bind { value in
            guard let value else { return }
            let chekcedCoinResult = self.repository.checkedCoinID(value)
            self.outputFavoriteBtnReslut.value = chekcedCoinResult
            self.outputSearchList.value = self.updateFavorite(self.outputSearchList.value)
        }
    }
}

extension SearchViewModel {
    
    private func getSearchList(_ query: String) {
        isLoading.value = true
        
        CoinGeckoAPIManager.shared.callRequest(type: Search.self, api: .search(query: query)) { result in
            switch result {
            case .success(let data):
                let data = self.updateFavorite(data.coins)
                self.outputSearchList.value = data
            case .failure(let failure):
                self.outputNetworkErrorMessage.value = failure.rawValue
            }
            self.isLoading.value = false
        }
    }
    
    private func updateFavorite(_ coins: [Serach_Coin]) -> [Serach_Coin] {
        let ids = self.repository.fetchCoinID()
        var newCoins = coins
        for i in 0..<newCoins.count {
            if ids.contains(newCoins[i].id) {
                newCoins[i].favorite = true
            } else {
                newCoins[i].favorite = false
            }
        }
        return newCoins
    }
}
