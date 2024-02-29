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
    
    var list: [Market] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewWillAppearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension FavoriteViewController {
    
    private func configureView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func bindData() {
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
        
        let data = list[indexPath.row]
        cell.updateView(data)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.viewModel.inputCoinID.value = list[indexPath.row].id
        
        transition(viewController: vc, style: .push)
    }
}
