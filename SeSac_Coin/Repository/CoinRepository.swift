//
//  TodoTableRepository.swift
//  SeSac_TodoList
//
//  Created by youngjoo on 2/16/24.
//

import Foundation
import RealmSwift

final class CoinRepository {
    
    let realm = try! Realm()
    
    func fetchCoinID() -> [String] {
        print(realm.configuration.fileURL!)
        return Array(fetchFavoriteCoin()).map { $0.coinID }
    }
    
    func checkedCoinID(_ id: String) -> String {
        if let coin = fetchFavoriteCoin().first(where: { $0.coinID == id }) {
            deleteItem(coin)
            return "즐겨찾기 해제 완료!"
        } else {
            return self.createCoin(id)
        }
    }
    
    func createCoin(_ id: String) -> String {
        if fetchCoinID().count >= 10 {
            return "즐겨찾기는 최대 10개까지 가능합니다."
        } else {
            createItem(id)
            return "즐겨찾기 등록 완료!"
        }
    }
    
}


// MARK: - Private
extension CoinRepository {
    
    private func createItem(_ coinID: String) {
        do {
            try realm.write {
                realm.add(FavoriteCoin(coinID: coinID))
                print("즐겨찾기 성공")
            }
        } catch {
            print("생성 에러: ", error)
        }
    }
    
    private func deleteItem(_ item: FavoriteCoin) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("삭제 에러: ", error)
        }
    }
    
    private func fetchFavoriteCoin() -> Results<FavoriteCoin> {
        return realm.objects(FavoriteCoin.self)
    }
}
