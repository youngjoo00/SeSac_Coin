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
    
    var outputSearchList: Observable<[Coin]> = Observable([])
    var outputFavoriteBtnReslut: Observable<String> = Observable("")
    
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputSearchBarText.bind { value in
            guard let value else { return }

            self.fetchSearchList(value) { data in
                self.outputSearchList.value = data
            }
        }
        
        inputFavoriteBtnTapped.bind { value in
            guard let value else { return }
            let result = self.checkedCoinID(value)
            self.outputSearchList.value = self.updateFavorite(self.outputSearchList.value)
            self.outputFavoriteBtnReslut.value = result
        }
    }
    
    private func fetchSearchList(_ query: String, completionHandler: @escaping ([Coin]) -> Void) {
        
        CoinGeckoAPIManager.shared.callRequest(type: Search.self, api: .search(query: query)) { data, error in
            if let data {
                let coin = self.updateFavorite(data.coins)
                completionHandler(coin)
            } else if let error {
                print("Error!!:", error)
            }
        }
    }
    
    private func checkedCoinID(_ id: String) -> String {
        if let coin = repository.fetchFavoriteCoin().first(where: { $0.coinID == id }) {
            repository.deleteItem(coin)
            return "즐겨찾기 해제 완료!"
        } else {
            return self.createItem(id)
        }
    }
    
    private func createItem(_ id: String) -> String {
        if repository.fetchCoinID().count >= 10 {
            return "즐겨찾기는 최대 10개까지 가능합니다."
        } else {
            repository.createItem(id)
            return "즐겨찾기 등록 완료!"
        }
        
    }
    
    private func updateFavorite(_ coins: [Coin]) -> [Coin] {
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
