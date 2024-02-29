//
//  NumberFormatter+Extension.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import Foundation
import Then

final class NumberFormatterManager {

    static let shared = NumberFormatterManager()
    
    private let numberFormatter = NumberFormatter().then {
        $0.numberStyle = .currency
        $0.currencyCode = "KRW"
        $0.maximumFractionDigits = 2
    }

    private init() { }
    
    
    func formatted<T: Numeric>(_ number: T) -> String? {
        return numberFormatter.string(from: number as! NSNumber)
    }
    
    deinit {
        print(#function, "deinit!")
    }
}
