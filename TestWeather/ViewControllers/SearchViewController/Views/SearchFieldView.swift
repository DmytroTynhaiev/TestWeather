//
//  SearchFieldView.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import UIKit

protocol SearchFieldViewDelegate: AnyObject {
    func updateSearchResults(_ text: String)
}

class SearchFieldView: UIView {

    weak var delegate: SearchFieldViewDelegate?
    
    static func loadView() -> SearchFieldView {
        return Bundle.main.loadNibNamed("SearchFieldView", owner: nil)?.last as! SearchFieldView
    }
    
    // MARK: - Actions
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        guard let text = sender.text else { return }
        delegate?.updateSearchResults(text)
    }
    
}
