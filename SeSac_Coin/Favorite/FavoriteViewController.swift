//
//  FavoriteViewController.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit

final class FavoriteViewController: BaseViewController {
    
    private let mainView = FavoriteView()
    private let viewModel = FavoriteViewModel()
    
    var list: [FavoriteCoin] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindData()
    }
    
}

// MARK: - Custom Func
extension FavoriteViewController {
    
    private func configureView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputList.bind { data in
            self.list = data
            self.mainView.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        
        cell.coinImageView.image = UIImage(systemName: "star")
        cell.titleLabel.text = "title"
        cell.subTitleLabel.text = "subTitle"
        cell.priceLabel.text = "200,000,000"
        cell.percentageLabel.text = "+0.58%"
        return cell
    }
    
    
}
