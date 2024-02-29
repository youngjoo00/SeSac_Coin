//
//  FavoriteCollectionViewCell.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/28/24.
//

import UIKit
import Then
import Kingfisher

final class FavoriteCollectionViewCell: BaseCollectionViewCell {
    
    private let cornerRadius: CGFloat = 10.0
    
    private let coinImageView = UIImageView()
    private let titleLabel = CellTitleLabel().then {
        $0.numberOfLines = 2
    }
    
    private let subTitleLabel = CellSubTitleLabel()
    private let priceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let percentageLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    private let percentageView = UIView().then {
        $0.layer.cornerRadius = 4
    }
    
    private let shadowView = UIView().then {
        $0.backgroundColor = .white
        //$0.layer.masksToBounds = false
        //$0.layer.shadowOpacity = 0.8
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
            percentageView,
            percentageLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coinImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(10)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView)
            make.leading.equalTo(coinImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.height.equalTo(36)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(percentageView.snp.top).offset(-5)
            make.trailing.equalTo(percentageLabel)
            make.height.equalTo(20)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(contentView).offset(-20)
            make.height.equalTo(14)
        }
        
        percentageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(percentageLabel).inset(-10)
            make.verticalEdges.equalTo(percentageLabel).inset(-5)
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

extension FavoriteCollectionViewCell {
    
    func updateView(_ data: Market) {
        let url = URL(string: data.image)
        coinImageView.kf.setImage(with: url)
        
        titleLabel.text = data.name
        subTitleLabel.text = data.symbol
        priceLabel.text = NumberFormatterManager.shared.formatted(data.current_price)
        
        let percentData = data.price_change_percentage_24h
        if percentData >= 0 {
            percentageLabel.text = "+\(percentData.formattedPercent)"
            percentageLabel.textColor = .sesacRed
            percentageView.backgroundColor = .sesacPink
        } else {
            percentageLabel.text = percentData.formattedPercent
            percentageLabel.textColor = .sesacBlue
            percentageView.backgroundColor = .sesacSky
        }
    }
    
}
