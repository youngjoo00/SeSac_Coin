//
//  TrendView.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit
import Then

final class TrendView: BaseView {
    
    let titleLabel = TitleLabel().then {
        $0.text = "Crypto Coin"
    }
    
    override func configureHierarchy() {
        [
            titleLabel
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        
    }
}
