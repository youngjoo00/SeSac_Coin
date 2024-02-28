//
//  StarButton.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit

class FavoriteButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoriteButton {
    
    func configureView() {
        setImage(UIImage(resource: .btnStar), for: .normal) 
        setImage(UIImage(resource: .btnStarFill), for: .normal)
    }
}
