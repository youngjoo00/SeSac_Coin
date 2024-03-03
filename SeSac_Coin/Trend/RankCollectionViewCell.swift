//
//  RankCollectionViewCell.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/1/24.
//

import UIKit
import Then

final class RankCollectionViewCell: BaseCollectionViewCell {
    
    let rankLabel = SeSacColorLabel(color: .sesac_LightBlack).then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    let coinImageView = UIImageView()
    let titleLabel = SeSacColorLabel(color: .sesac_LightBlack).then {
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    let subTitleLabel = SeSacColorLabel(color: .sesac_LightBlack).then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    let priceLabel = SeSacColorLabel(color: .sesac_LightBlack).then {
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    let percentageLabel = SeSacColorLabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .sesacLightGray
    }
    
    override func configureHierarchy() {
        [
            rankLabel,
            coinImageView,
            titleLabel,
            subTitleLabel,
            priceLabel,
            percentageLabel,
            lineView
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView).offset(10)
        }
        
        coinImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankLabel.snp.trailing).offset(20)
            make.size.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY).offset(-1)
            make.leading.equalTo(coinImageView.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-5)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.centerY).offset(1)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(percentageLabel.snp.leading).offset(-5)
        }
        subTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(titleLabel)
        }
        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel)
            make.trailing.equalToSuperview().offset(-16)
        }
        percentageLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        lineView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func configureView() {
        
    }
}

extension RankCollectionViewCell {
    
    func checkedType(_ data: Any, indexPath: Int) {
        switch data {
        case is Trend_Item:
            updateCoin(data as! Trend_Item, indexPath: indexPath)
        case is Trend_NFT:
            updateNFT(data as! Trend_NFT, indexPath: indexPath)
        default:
            return
        }
    }
    
    func updateCoin(_ data: Trend_Item, indexPath: Int) {
        let data = data.item
        
        rankLabel.text = "\(indexPath + 1)"
        
        let url = URL(string: data.small)
        coinImageView.kf.setImage(with: url)
        
        titleLabel.text = data.name
        subTitleLabel.text = data.symbol
        priceLabel.text = data.priceData.price.htmlEscaped
        percentageLabel.updatePercentage(data.priceData.price_change_percentage_24h.krw)
    }
    
    func updateNFT(_ data: Trend_NFT, indexPath: Int) {
        rankLabel.text = "\(indexPath + 1)"
        
        let url = URL(string: data.thumb)
        coinImageView.kf.setImage(with: url)
        
        titleLabel.text = data.name
        subTitleLabel.text = data.symbol
        priceLabel.text = data.priceData.floor_price
        
        if let percentagePrice = Double(data.priceData.floor_price_in_usd_24h_percentage_change) {
            percentageLabel.updatePercentage(percentagePrice)
        }
    }
}
