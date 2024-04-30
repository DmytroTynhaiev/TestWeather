//
//  SearchViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func updateTableView(with cities: [SearchCellModel])
}

class SearchViewController: BaseTableViewController {

    var model = SearchViewControllerModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.fetchCities()
    }
    
    // MARK: - Private
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchView = SearchFieldView.loadView()
        searchView.delegate = self
        return searchView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 76.0
    }

}

// MARK: - SearchViewControllerDelegate

extension SearchViewController: SearchViewControllerDelegate {
    
    func updateTableView(with cities: [SearchCellModel]) {
        self.dataSource = cities
        self.tableView.reloadData()
    }
 
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: SearchFieldViewDelegate {
    func updateSearchResults(_ text: String) {
        self.model.search(text)
    }
}
 


