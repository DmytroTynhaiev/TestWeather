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
        self.configureSearchBar()
        self.model.delegate = self
        self.model.fetchCities()
    }
    
    // MARK: - Private
    
    private func configureSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        self.navigationItem.searchController = search
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

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.model.search(text)
    }
    
}
 

