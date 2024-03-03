//
//  ChartViewController.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import UIKit
import SVProgressHUD

final class ChartViewController: BaseViewController {
    
    let mainView = ChartView()
    let viewModel = ChartViewModel()
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.inputViewDidAppearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension ChartViewController {
    
    private func bindViewModel() {
        
        viewModel.isLoading.bind { isLoading in
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputNetworkErrorMessage.bind { message in
            guard let message else { return }
            self.showToast(message: message)
        }
        
        viewModel.outputChartData.bind { data in
            self.mainView.updateView(data)
        }
        
        viewModel.outputFavoriteBtnReslut.bind { message in
            guard let message else { return }
            self.showToast(message: message)
        }
        
        viewModel.outputFavoriteBtnState.bind { value in
            if value {
                self.navigationItem.rightBarButtonItem?.image = UIImage(resource: .btnStarFill)
            } else {
                self.navigationItem.rightBarButtonItem?.image = UIImage(resource: .btnStar)
            }
        }
    }
    
    @objc func didRightBarButtonItemTapped() {
        viewModel.inputFavoriteBtnTapped.value = ()
    }
    
    private func configureNavigationBar() {
        let rightBtnItem = UIBarButtonItem(image: UIImage(resource: .btnStar), style: .plain, target: self, action: #selector(didRightBarButtonItemTapped))
        
        navigationItem.rightBarButtonItem = rightBtnItem
    }
}

extension ChartViewController: FavoriteBtnDelegate {
    func updateFavoriteBtn(cell: UITableViewCell) {
        
    }
    
    
}
