//
//  TrendViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/1/24.
//

import Foundation

enum TrendSection: Int, CaseIterable {
    case Favorite
    case Top15
    case NFT
    
    var sectionString: String {
        switch self {
        case .Favorite:
            return "My Favortie"
        case .Top15:
            return "Top15 Coin"
        case .NFT:
            return "Top7 NFT"
        }
    }
}

class TrendViewModel {
    
    private let repository = CoinRepository()
    
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    
    var dataList: Observable<[[Any]]> = Observable(Array(repeating: [], count: TrendSection.allCases.count))
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidAppearTrigger.bind { _ in
            self.getData()
        }
    }
    
}


extension TrendViewModel {
    
    private func getData() {
        isLoading.value = true
        
        var favorites: [Market] = []
        var coins: [Trend_Item] = []
        var nfts: [Trend_NFT] = []
        
        let group = DispatchGroup()
        
        let id = self.repository.fetchCoinID()
        if id.count >= 2 {
            group.enter()
            CoinGeckoAPIManager.shared.callRequest(type: [Market].self, api: .favorite(id: id)) { result in
                switch result {
                case .success(let data):
                    favorites = data
                case .failure(let failure):
                    self.isLoading.value = false
                    return self.outputNetworkErrorMessage.value = failure.rawValue
                }
                group.leave()
            }
        }
        
        group.enter()
        CoinGeckoAPIManager.shared.callRequest(type: Trend.self, api: .trend) { result in
            switch result {
            case .success(let data):
                let coinData = data.coins.sorted(by: {
                    $0.item.rank < $1.item.rank
                })
                coins = coinData
                nfts = data.nfts
            case .failure(let failure):
                self.isLoading.value = false
                return self.outputNetworkErrorMessage.value = failure.rawValue
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.isLoading.value = false
            let list: [[Any]] = [favorites, coins, nfts]
            self.dataList.value = list
        }
        
    }
    
}
