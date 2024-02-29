//
//  SeSacBlueLabel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import UIKit

final class SeSacBlueLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeSacBlueLabel {
    
    func configureView() {
        textColor = .sesacBlue
    }
}
