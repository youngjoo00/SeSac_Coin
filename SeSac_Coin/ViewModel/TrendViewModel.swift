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
    var inputCheckedCollectionViewTag: Observable<(Int?, IndexPath?)> = Observable((nil, nil))
    
    var dataList: Observable<[[Any]]> = Observable(Array(repeating: [], count: TrendSection.allCases.count))
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputTransition: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)

    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidAppearTrigger.bind { _ in
            self.getData()
        }
        
        inputCheckedCollectionViewTag.bind { tag, indexPath in
            guard let tag, let indexPath else { return }
            
            if tag == 0 && indexPath.item == 3 {
                self.outputTransition.value = "more"
            } else {
                let resultStinrg = self.checkedTag(tag, indexPath: indexPath)
                self.outputTransition.value = resultStinrg
            }
        }
    }
    
    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return dataList.value[indexPath.section].count >= 2 ? 230 : 0
        } else {
            return 300
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
}


extension TrendViewModel {
    
    // 이렇게 통신으로 값을 가져오는 경우에도 사이드이펙트를 최소화하기 위해 반환값으로 던져주는게 좋은지 궁금합니다,,!
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
                    favorites = data.count >= 4 ? Array(data[0...3]) : data
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
    
    private func checkedTag(_ tag: Int, indexPath: IndexPath) -> String? {
        if tag != 2 {
            let data = dataList.value[tag][indexPath.item]
            switch data {
            case is Market:
                return (data as! Market).id
            case is Trend_Item:
                return (data as! Trend_Item).item.id
            default:
                return nil
            }
        }
        return nil
    }
}
