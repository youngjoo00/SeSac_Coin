//
//  CellSubTitleLabel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import UIKit

class CellSubTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CellSubTitleLabel {
    
    func configureView() {
        textColor = .sesacDarkGray
        font = .boldSystemFont(ofSize: 15)
    }
}
