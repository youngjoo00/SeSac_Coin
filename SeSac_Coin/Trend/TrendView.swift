//
//  TrendView.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit
import Then

final class TrendView: BaseView {
    
    let titleLabel = TitleLabel().then {
        $0.text = "Crypto Coin"
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        $0.separatorStyle = .none
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            tableView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
