//
//  SearchViewController.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/27/24.
//

import UIKit
import SVProgressHUD

final class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var list: [Serach_Coin] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
    }
    
}


// MARK: - Custom Func
extension SearchViewController {
    
    private func configureView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.searchBar.delegate = self
    }
    
    private func bindViewModel() {
        
        viewModel.isLoading.bind { isLoding in
            if isLoding {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputSearchList.bind { value in
            self.list = value
            self.mainView.tableView.reloadData()
        }
        
        viewModel.outputFavoriteBtnReslut.bind { message in
            guard let message else { return }
            self.showToast(message: message)
        }
        
        viewModel.outputNetworkErrorMessage.bind { message in
            guard let message else { return }
            self.showToast(message: message)
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
        let vc = ChartViewController()
        vc.viewModel.inputCoinID.value = list[indexPath.row].id
        transition(viewController: vc, style: .push)
    }
}


// MARK: - Custom Delegate
extension SearchViewController: FavoriteBtnDelegate {
    func updateFavoriteBtn(cell: UITableViewCell) {
        if let indexPath = mainView.tableView.indexPath(for: cell) {
            let item = list[indexPath.row].id
            viewModel.inputFavoriteBtnTapped.value = item
        }
    }
}


// MARK: - SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBarText.value = searchBar.text
    }
}


