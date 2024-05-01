//
//  SearchViewControllerModel.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import Foundation

class SearchViewControllerModel {
    
    private var savedCities: [SavedCity] = []
    private var searchedCities: [City] = []
    private var filteredCities: [City] = []
    weak var delegate: SearchViewControllerDelegate?
    
    func fetchSavedCities() {
        let context = TestWeatherPersistenceController.context
        let request = SavedCity.fetchRequest()
        let result = try? context.fetch(request)
        let cities = result?.compactMap { City(from: $0) }
        let cellModels = self.configureCellModel(cities ?? [])
        
        self.savedCities = result!
        self.delegate?.updateTableView(with: cellModels)
    }
        
    func fetchCities() {
        let path = "https://raw.githubusercontent.com/JetSetExpert/cities-json/master/data/cities.json"
        NetworkService.shared.request(path: path, method: .get, decadable: [City].self) { response in 
            
            let cellModels = self.configureCellModel(response)
            self.searchedCities = response
            self.filteredCities = response
            self.delegate?.updateResultTableView(with: cellModels)
            
        } failure: { error in print(error) }
    }
    
    func search(_ text: String) {
        let filteredCities = self.searchedCities.filter { $0.cityASCII.lowercased().contains(text.lowercased()) }
        let cities = filteredCities.count > 0 ? filteredCities : self.searchedCities
        let cellModels = self.configureCellModel(cities)
        self.filteredCities = cities
        self.delegate?.updateResultTableView(with: cellModels)
    }
    
    
    func save(_ index: Int) {
        let city = self.filteredCities[index]
        _ = SavedCity(from: city)
        TestWeatherPersistenceController.save()
        self.fetchSavedCities()
    }
    
    func delete(_ index: Int) {
        let city = self.savedCities[index]
        TestWeatherPersistenceController.delete(city)
    }
    
    // MARK: - Private
    
    private func configureCellModel(_ response: [City]) -> [SearchCellModel] {
        return response.compactMap {
            return SearchCellModel(city: $0.city, country: $0.country)
        }
    }

}
