//
//  Double+Extension.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import Foundation

extension Double {
    var formattedPercent: String {
        let formatString = String(format: "%.2f", self)
        return formatString + "%"
    }
}
