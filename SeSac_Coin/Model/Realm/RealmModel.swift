//
//  TodoModel.swift
//  SeSac_TodoList
//
//  Created by youngjoo on 2/15/24.
//

import Foundation
import RealmSwift

final class FavoriteCoin: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var coinID: String
    
    convenience init(coinID: String) {
        self.init()
        self.coinID = coinID
    }
}
