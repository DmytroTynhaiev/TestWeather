//
//  SearchResultViewCell.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import UIKit

class SearchResultViewCell: BaseTableViewCell<SearchCellModel> {
    
    @IBOutlet weak var citytLabel: UILabel!
    
    override var viewModel: SearchCellModel! {
        didSet {
            self.citytLabel.text = "\(viewModel.city) / \(viewModel.country)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.citytLabel.text = ""
    }
    
}
