//
//  TitleLabel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit

final class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension TitleLabel {
    
    func configureView() {
        textColor = .sesacBlack
        font = .boldSystemFont(ofSize: 30)
    }
}
