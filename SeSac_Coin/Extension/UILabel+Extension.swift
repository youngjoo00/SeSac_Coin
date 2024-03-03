//
//  UILabel+Extension.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/1/24.
//

import UIKit

extension UILabel {
    
    func updatePercentage(_ data: Double) {
        if data >= 0 {
            self.text = "+\(data.formattedPercent)"
            self.textColor = .sesacRed
        } else {
            self.text = data.formattedPercent
            self.textColor = .sesacBlue
        }
    }
}
