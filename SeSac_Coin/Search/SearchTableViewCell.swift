//
//  SearchTableViewCell.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit
import Then
import Kingfisher

protocol FavoriteBtnDelegate: AnyObject {
    func updateFavoriteBtn(cell: UITableViewCell)
}

final class SearchTableViewCell: BaseTableViewCell {
    
    private let coinImageView = UIImageView()
    private let titleLabel = CellTitleLabel()
    private let subTitleLabel = CellSubTitleLabel()
    private let favoriteBtn = FavoriteButton()
    
    weak var delegate: FavoriteBtnDelegate?
    
    override func configureHierarchy() {
        [
            coinImageView,
            titleLabel,
            subTitleLabel,
            favoriteBtn,
        ].forEach { contentView.addSubview($0) }
    }

    override func configureLayout() {
        coinImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView)
            make.leading.equalTo(coinImageView.snp.trailing).offset(16)
            make.height.equalTo(18)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(15)
        }
        
        favoriteBtn.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
    
    override func configureView() {
        favoriteBtn.addTarget(self, action: #selector(didFavoriteBtnTapped), for: .touchUpInside)
    }
}


// MARK: - Custom Func
extension SearchTableViewCell {
    
    @objc func didFavoriteBtnTapped() {
        delegate?.updateFavoriteBtn(cell: self)
    }
    
    func updateView(_ data: Coin, searchText: String?) {
        let url = URL(string: data.thumb)
        coinImageView.kf.setImage(with: url)
        titleLabel.text = data.name
        subTitleLabel.text = data.symbol
        
        if let searchText {
            let attributeString = configureAttributeString(data.name, searchText: searchText)
            titleLabel.attributedText = attributeString
        }
        
        if data.favorite {
            favoriteBtn.setImage(UIImage(resource: .btnStarFill), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(resource: .btnStar), for: .normal)
        }
    }
    
    // 대소문자 구분 없이 검색한 키워드와 같은 경우 컬러 변경
    private func configureAttributeString(_ title: String, searchText: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: title)
        
        attributeString.addAttribute(.foregroundColor,
                                     value: UIColor.sesacPuple,
                                     range: (title as NSString).range(of: searchText, options: .caseInsensitive))
        
        return attributeString
    }
}
