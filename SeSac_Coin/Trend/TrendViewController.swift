//
//  TrendViewController.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit
import SVProgressHUD

final class TrendViewController: BaseViewController {
    
    let mainView = TrendView()
    let viewModel = TrendViewModel()
    
    var dataList: [[Any]] = [Array(repeating: [], count: TrendSection.allCases.count)]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputViewDidAppearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension TrendViewController {
    
    private func configureView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func bindViewModel() {
        
        viewModel.isLoading.bind { isLoading in
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.dataList.bind { _ in
            self.dataList = self.viewModel.dataList.value
            self.mainView.tableView.reloadData()
        }
        
        viewModel.outputNetworkErrorMessage.bind { error in
            guard let error else { return }
            self.showToast(message: error)
        }
    }
}


// MARK: - TableView
extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        
        if indexPath.section == 0 {
            cell.favoriteCollectionView.tag = indexPath.section
            cell.titleLabel.text = TrendSection.allCases[indexPath.section].sectionString
            cell.favoriteCollectionView.isHidden = dataList[indexPath.section].count <= 1
            cell.rankCollectionView.isHidden = true
            cell.favoriteCollectionView.delegate = self
            cell.favoriteCollectionView.dataSource = self
        } else {
            cell.rankCollectionView.tag = indexPath.section
            cell.titleLabel.text = TrendSection.allCases[indexPath.section].sectionString
            cell.rankCollectionView.isHidden = false
            cell.favoriteCollectionView.isHidden = true
            cell.rankCollectionView.delegate = self
            cell.rankCollectionView.dataSource = self
        }

        cell.favoriteCollectionView.reloadData()
        cell.rankCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return dataList[indexPath.section].count >= 2 ? 230 : 0
        } else {
            return 300
        }
    }
}


// MARK: - CollectionView
extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = dataList[collectionView.tag][indexPath.item]
        
        if collectionView.tag == 0 {
            let favoriteCell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendFavortieCollectionViewCell.identifier, for: indexPath) as! TrendFavortieCollectionViewCell
            
            if let data = data as? Market {
                favoriteCell.updateView(data)
            }
            
            return favoriteCell
        } else {
            let rankCell = collectionView.dequeueReusableCell(withReuseIdentifier: RankCollectionViewCell.identifier, for: indexPath) as! RankCollectionViewCell
            
            rankCell.checkedType(data, indexPath: indexPath.item)
            return rankCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag != 2 {
            let vc = ChartViewController()
            let data = dataList[collectionView.tag][indexPath.item]
            switch data {
            case is Market:
                vc.viewModel.inputCoinID.value = (data as! Market).id
            case is Trend_Item:
                vc.viewModel.inputCoinID.value = (data as! Trend_Item).item.id
            default:
                return
            }
            transition(viewController: vc, style: .push)
        }

    }
}
