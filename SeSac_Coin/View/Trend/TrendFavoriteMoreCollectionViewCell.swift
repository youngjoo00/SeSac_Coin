//
//  TrendFavoriteMoreCollectionViewCell.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/3/24.
//

import UIKit
import Then
import Kingfisher

final class TrendFavortieMoreCollectionViewCell: BaseCollectionViewCell {
    
    private let plusImageView = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = .sesacDarkGray
    }
    private let titleLabel = SeSacColorLabel(color: .sesac_DarkGray).then {
        $0.text = "더 보기"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    override func configureHierarchy() {
        [
            plusImageView,
            titleLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        plusImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(plusImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    override func configureView() {
        layer.cornerRadius = 16
        backgroundColor = .sesacLightGray
    }
}
