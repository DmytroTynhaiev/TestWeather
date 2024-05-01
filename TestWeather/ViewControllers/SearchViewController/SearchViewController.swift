//
//  SearchViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func updateTableView(with cities: [SearchCellModel])
    func updateResultTableView(with cities: [SearchCellModel])
}

class SearchViewController: BaseTableViewController {

    var model = SearchViewControllerModel()
    var resultController = SearchResultViewcontroller.instantiate()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.fetchSavedCities()
        self.configureSearchController()
    }
    
    private func configureSearchController() {
        self.resultController.viewModel = self.model
        let search = UISearchController(searchResultsController: self.resultController)
        search.delegate = self
        search.searchResultsUpdater = self
        search.searchSuggestions = []
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Сity search"
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dataSource?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.model.delete(indexPath.row)
        }
    }
}

// MARK: - SearchViewControllerDelegate

extension SearchViewController: SearchViewControllerDelegate {
    
    func updateTableView(with cities: [SearchCellModel]) {
        self.dataSource = cities
        self.tableView.reloadData()
    }
    
    func updateResultTableView(with cities: [SearchCellModel]) {
        self.resultController.dataSource = cities
        self.resultController.tableView.reloadData()
    }
 
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        searchController.showsSearchResultsController = true
    }
        
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.model.search(text)
    }

}
 


