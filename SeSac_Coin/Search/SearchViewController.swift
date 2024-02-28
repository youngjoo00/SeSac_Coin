//
//  SearchViewController.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var list: [Coin] = []
    
    let repository = CoinRepository()
    
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
extension SearchViewController {
    
    private func configureView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.searchBar.delegate = self
    }
    
    private func bindData() {
        viewModel.outputSearchList.bind { value in
            self.list = value
            self.mainView.tableView.reloadData()
        }
    }
}


// MARK: - TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        let data = list[indexPath.row]
        cell.updateView(data, searchText: viewModel.inputSearchBarText.value)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("차트로 화면 이동")
    }
}


// MARK: - SearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBarText.value = searchBar.text
    }
}

extension SearchViewController: FavoriteBtnDelegate {
    func updateFavoriteBtn(cell: UITableViewCell) {
        // 1. 우선 DB 에 값이 10개 이하인지 확인
        // 2. 내 데이터베이스에서 있는지 확인하기
        if let indexPath = mainView.tableView.indexPath(for: cell) {
            let item = list[indexPath.row]
            repository.createItem(item.id)
        }
    }
    
    
}
