//
//  SearchResultViewcontroller.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import UIKit

class SearchResultViewcontroller: BaseTableViewController {
    
    weak var viewModel: SearchViewControllerModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.fetchCities()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.save(indexPath.row)
        self.dismiss(animated: true)
    }
    
}
