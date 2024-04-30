//
//  SearchTableViewCell.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import UIKit

struct SearchCellModel: BaseTableCellModel {
    var identifier = "SearchTableViewCell"
    var city: String
    var country: String
}

class SearchTableViewCell: BaseTableViewCell<SearchCellModel> {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override var viewModel: SearchCellModel! {
        didSet {
            cityLabel.text = viewModel.city
            countryLabel.text = viewModel.country
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityLabel.text = ""
        self.countryLabel.text = ""
    }
    
}
