//
//  CellTitleLabel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import UIKit

class CellTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CellTitleLabel {
    
    func configureView() {
        textColor = .sesacBlack
        font = .boldSystemFont(ofSize: 18)
    }
}
