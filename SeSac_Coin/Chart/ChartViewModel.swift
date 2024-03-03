//
//  ChartViewModel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import Foundation

final class ChartViewModel {
    
    private let repository = CoinRepository()
    
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    var inputCoinID: Observable<String?> = Observable(nil)
    var inputFavoriteBtnTapped: Observable<Void?> = Observable(nil)
    
    var outputChartData: Observable<Market?> = Observable(nil)
    var outputFavoriteBtnState = Observable(false)
    var outputFavoriteBtnReslut: Observable<String?> = Observable(nil)
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        
        inputViewDidAppearTrigger.bind { _ in
            self.getChartData()
        }
        
        inputFavoriteBtnTapped.bind { _ in
            guard let id = self.inputCoinID.value else { return }
            let chekcedCoinResult = self.repository.checkedCoinID(id)
            self.outputFavoriteBtnReslut.value = chekcedCoinResult
            self.outputFavoriteBtnState.value = self.checkedFavoriteBtn(id)
        }
    }
}


extension ChartViewModel {
    
    private func getChartData() {
        isLoading.value = true
        
        guard let id = inputCoinID.value else {
            return isLoading.value = false
        }
        
        CoinGeckoAPIManager.shared.callRequest(type: [Market].self, api: .market(id: id)) { result in
            switch result {
            case .success(let data):
                self.outputChartData.value = data.first
                self.outputFavoriteBtnState.value = self.checkedFavoriteBtn(id)
            case .failure(let failure):
                self.outputNetworkErrorMessage.value = failure.rawValue
            }
            self.isLoading.value = false
        }
    }
    
    private func checkedFavoriteBtn(_ id: String) -> Bool {
        let ids = self.repository.fetchCoinID()
        
        return ids.contains(id) ? true : false
    }
    
}
