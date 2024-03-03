//
//  SearchView.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit
import Then

final class SearchView: BaseView {
    
    private let titleLabel = TitleLabel().then {
        $0.text = "Search"
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "코인을 검색해보세요!"
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.separatorStyle = .none
    }
        
    override func configureHierarchy() {
        [
            titleLabel,
            searchBar,
            tableView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        
    }
}
