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
    
    func createItem(_ coinID: String) {
        do {
            try realm.write {
                realm.add(FavoriteCoin(coinID: coinID))
                print("즐겨찾기 성공")
            }
        } catch {
            print("생성 에러: ", error)
        }
    }
    
    func fetchCoinID() -> [String] {
        print(realm.configuration.fileURL)
        return Array(fetchFavoriteCoin()).map { $0.coinID }
    }
    
    func deleteItem(_ item: FavoriteCoin) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("삭제 에러: ", error)
        }
    }
}


// MARK: - Private
extension CoinRepository {
    
    func fetchFavoriteCoin() -> Results<FavoriteCoin> {
        return realm.objects(FavoriteCoin.self)
    }
}
