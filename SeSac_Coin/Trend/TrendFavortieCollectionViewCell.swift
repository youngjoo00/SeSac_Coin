//
//  TrendFavortieCollectionViewCell.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/2/24.
//

import UIKit
import Then
import Kingfisher

final class TrendFavortieCollectionViewCell: BaseCollectionViewCell {
    
    private let coinImageView = UIImageView()
    private let titleLabel = CellTitleLabel().then {
        $0.numberOfLines = 2
    }
    
    private let subTitleLabel = CellSubTitleLabel()
    private let priceLabel = SeSacColorLabel(color: .sesac_Black).then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let percentageLabel = SeSacColorLabel(color: .sesac_Black).then {
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    override func configureHierarchy() {
        [
            coinImageView,
            titleLabel,
            subTitleLabel,
            priceLabel,
            percentageLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        coinImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(20)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView)
            make.leading.equalTo(coinImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(percentageLabel.snp.top).offset(-10)
            make.leading.equalTo(coinImageView)
            make.height.equalTo(20)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView)
            make.bottom.equalTo(contentView).offset(-20)
            make.height.equalTo(17)
        }
        
    }
    
    override func configureView() {
        layer.cornerRadius = 16
        backgroundColor = .sesacLightGray
    }
}

extension TrendFavortieCollectionViewCell {
    
    func updateView(_ data: Market) {
        let url = URL(string: data.image)
        coinImageView.kf.setImage(with: url)
        
        titleLabel.text = data.name
        subTitleLabel.text = data.symbol
        priceLabel.text = NumberFormatterManager.shared.formattedKRW(data.current_price)
        
        let percentData = data.price_change_percentage_24h
        
        percentageLabel.updatePercentage(percentData)
    }
    
}
