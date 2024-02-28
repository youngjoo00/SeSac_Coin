//
//  FavoriteCollectionViewCell.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import UIKit
import Then

class FavoriteCollectionViewCell: BaseCollectionViewCell {
    
    let cornerRadius: CGFloat = 10.0
    
    let coinImageView = UIImageView()
    let titleLabel = CellTitleLabel()
    let subTitleLabel = CellSubTitleLabel()
    let priceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let percentageLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    let shadowView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.masksToBounds = false
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowOffset = CGSize(width: -2, height: 2)
        $0.layer.shadowRadius = 10
        $0.layer.shadowColor = UIColor.systemGray.cgColor
        $0.clipsToBounds = false
    }
    
    
    override func configureHierarchy() {
        [
            shadowView,
            coinImageView,
            titleLabel,
            subTitleLabel,
            priceLabel,
            percentageLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coinImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(20)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView)
            make.leading.equalTo(coinImageView.snp.trailing).offset(10)
            make.height.equalTo(18)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(percentageLabel.snp.top).offset(-5)
            make.trailing.equalTo(percentageLabel)
            make.height.equalTo(20)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(contentView).offset(-20)
            make.height.equalTo(14)
        }
    }
    
    override func configureView() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
