//
//  FavoriteViewController.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit
import SVProgressHUD

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
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputViewDidAppearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension FavoriteViewController {
    
    private func configureView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        configureRefreshControl()
    }
    
    private func bindViewModel() {
        
        viewModel.isLoding.bind { isLoding in
            if isLoding {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputList.bind { data in
            self.mainView.blockView.isHidden = true
            self.list = data
            self.mainView.collectionView.reloadData()
        }
        
        viewModel.outputNetworkErrorMessage.bind { message in
            guard let message else { return }
            
            self.mainView.blockView.isHidden = false
            self.mainView.blockView.retryBtn.addTarget(self, action: #selector(self.didRetryBtnTapped), for: .touchUpInside)
            
            self.showAlert(title: "오류!", message: message, btnTitle: "재시도") {
                self.viewModel.inputViewDidAppearTrigger.value = ()
            }
        }
        
        viewModel.outputTransition.bind { id in
            guard let id else { return }
            let vc = ChartViewController()
            vc.viewModel.inputCoinID.value = id
            self.transition(viewController: vc, style: .push)
        }
    }
    
    private func configureRefreshControl() {
        mainView.collectionView.refreshControl = UIRefreshControl()
        mainView.collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshData), for: .valueChanged)
        mainView.collectionView.refreshControl?.attributedTitle = NSAttributedString(string: "코인 정보 캐오는 중...")
    }
    
    @objc private func handleRefreshData(_ sender: UIRefreshControl) {
        viewModel.inputViewDidAppearTrigger.value = ()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            sender.endRefreshing()
        }
    }
    
    @objc private func didRetryBtnTapped() {
        viewModel.inputViewDidAppearTrigger.value = ()
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
        viewModel.inputDidSelectItemAtCoinID.value = list[indexPath.row].id
    }
}
