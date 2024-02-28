//
//  SearchViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import Foundation

final class SearchViewModel {
    
    var inputSearchBarText: Observable<String?> = Observable(nil)
    
    var outputSearchList: Observable<[Coin]> = Observable([])
    
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
        
    }
    
    private func fetchSearchList(_ query: String, completionHandler: @escaping ([Coin]) -> Void) {
        
        CoinGeckoAPIManager.shared.callRequest(type: Search.self, api: .search(query: query)) { data, error in
            if let data {
                completionHandler(data.coins)
            } else if let error {
                print(error)
            }
        }
    }
    
}
