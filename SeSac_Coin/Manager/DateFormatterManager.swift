//
//  DateFormatterManager.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import Foundation
import Then

class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    private init() { }

    func dateFormat(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "M/dd HH:mm:ss 업데이트"
        displayFormatter.locale = Locale(identifier: "ko_KR")

        guard let date = dateFormatter.date(from: date) else { return nil }
        
        return displayFormatter.string(from: date)
    }
}

