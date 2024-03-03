//
//  TrendTableViewCell.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/1/24.
//

import UIKit

class TrendTableViewCell: BaseTableViewCell {
    
    let titleLabel = SeSacColorLabel(color: .sesac_Black).then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureFavoriteCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(TrendFavortieCollectionViewCell.self, forCellWithReuseIdentifier: TrendFavortieCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    let rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureRankCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            favoriteCollectionView,
            rankCollectionView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(20)
        }
        
        rankCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
}

extension TrendTableViewCell {
    
    static func configureRankCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        
        let cellWidth = UIScreen.main.bounds.width * 0.8

        layout.itemSize = CGSize(width: cellWidth, height: 70)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        return layout
    }

    static func configureFavoriteCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        
        let cellWidth = UIScreen.main.bounds.width * 0.6

        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.8)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal

        return layout
    }
}
