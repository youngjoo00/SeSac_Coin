//
//  BlockView.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/3/24.
//

import UIKit
import Then

final class BlockView: UIView {

    let retryBtn = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "재시도"
        configuration.image = UIImage(systemName: "arrow.clockwise")
        configuration.baseForegroundColor = .sesacPuple
        configuration.baseBackgroundColor = .sesacLightGray
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        addSubview(retryBtn)
        
        retryBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension BlockView {
    
    func configureView() {
        backgroundColor = .sesacWhite.withAlphaComponent(0.7)
        isHidden = true
    }
}
