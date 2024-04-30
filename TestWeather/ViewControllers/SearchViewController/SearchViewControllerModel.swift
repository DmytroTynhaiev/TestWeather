//
//  SearchViewControllerModel.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import Foundation

class SearchViewControllerModel {
    
    var cities: [City] = []
    
    weak var delegate: SearchViewControllerDelegate?
        
    func fetchCities() {
        let path = "https://raw.githubusercontent.com/JetSetExpert/cities-json/master/data/cities.json"
        NetworkService.shared.request(path: path, method: .get, decadable: [City].self) { response in 
            
            let cellModels = self.configureCellModel(response)
            self.cities = response
            self.delegate?.updateTableView(with: cellModels)
            
        } failure: { error in
            print(error)
        }
    }
    
    func search(_ text: String) {
        let filteredCities = cities.filter { $0.city?.contains(text) ?? false }
        let cities = filteredCities.count > 0 ? filteredCities : self.cities
        let cellModels = self.configureCellModel(cities)
        self.delegate?.updateTableView(with: cellModels)
    }
    
    private func configureCellModel(_ response: [City]) -> [SearchCellModel] {
        return response.compactMap {
            let city = $0.city ?? "Unknow"
            let country = $0.country ?? "Unknow"
            return SearchCellModel(city: city, country: country)
        }
    }

}
