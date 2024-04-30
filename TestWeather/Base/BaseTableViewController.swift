//
//  BaseTableViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import Foundation
import UIKit

class BaseTableViewController: UITableViewController {
    
    var dataSource: [BaseTableCellModel]?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.identifier, for: indexPath)
        self.configure(cell, model)
        return cell
    }
    
    func configure<T: BaseTableCellModel>(_ cell: UITableViewCell, _ model: T) {
        if let baseCell = cell as? BaseTableViewCell<T> {
            baseCell.viewModel = model
        }
    }
    
}

protocol BaseTableCellModel {
    var identifier: String { get }
}

class BaseTableViewCell<ViewModel: BaseTableCellModel>: UITableViewCell {
    var viewModel: ViewModel!
}


