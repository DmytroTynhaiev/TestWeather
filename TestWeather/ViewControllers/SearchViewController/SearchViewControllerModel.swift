//
//  SearchViewControllerModel.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import Foundation

class SearchViewControllerModel {
    
    var cities: [[String: Any]] = []
    
    weak var delegate: SearchViewControllerDelegate?
        
    func fetchCities() {
        let path = "https://raw.githubusercontent.com/JetSetExpert/cities-json/master/data/cities.json"
        NetworkService.shared.request(path: path, method: .get) { response in
         
            guard let response = response else { return }
            self.cities = response["array"] as! [[String : Any]]
            let cellModels = self.configureCellModel(self.cities)
            self.delegate?.updateTableView(with: cellModels)
                                    
        } failure: { error in
            print(error)
        }
    }
    
    func search(_ text: String) {
        let filteredCities = cities.filter { ($0["city"] as? String)?.contains(text) ?? false }
        let cities = filteredCities.count > 0 ? filteredCities : self.cities
        let cellModels = self.configureCellModel(cities)
        self.delegate?.updateTableView(with: cellModels)
    }
    
    private func configureCellModel(_ response: [[String: Any]]) -> [SearchCellModel] {
        return response.compactMap {
            let city = $0["city"] as! String
            let country = $0["country"] as! String
            return SearchCellModel(city: city, country: country)
        }
    }

}
