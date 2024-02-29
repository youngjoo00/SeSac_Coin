//
//  ChartViewController.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import UIKit

final class ChartViewController: BaseViewController {
    
    let mainView = ChartView()
    let viewModel = ChartViewModel()
    
    var list: [Market] = []
    
    override func loadView() {
        view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
}


// MARK: - Custom Func
extension ChartViewController {
    
    func bindData() {
        
        viewModel.outputList.bind { value in
            self.mainView.updateView(value.first)
        }
    }
}
