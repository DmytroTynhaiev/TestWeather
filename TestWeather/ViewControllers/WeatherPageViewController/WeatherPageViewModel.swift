//
//  WeatherPageViewModel.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import Foundation

class WeatherPageViewModel {
    
    var locationService = LocationService()
    weak var delegate: WeatherPageViewControllerDelegate?
    
    func getCities() {
        Task {
            
            let placemark = await locationService.getPlacemark()
            let name = placemark.locality ?? "NAN"
            let latitude = placemark.location?.coordinate.latitude ?? 0.0
            let longitude = placemark.location?.coordinate.longitude ?? 0.0
            let country = placemark.country ?? "NAN"
            let locationCity = City(city: name, lat: "\(latitude)", lng: "\(longitude)", country: country)
            
            
            let context = TestWeatherPersistenceController.context
            let request = SavedCity.fetchRequest()
            let result = try? context.fetch(request)
            let savedCities = result?.compactMap { City(from: $0) }
            
            DispatchQueue.main.async {
                
                var allCities = savedCities ?? []
                allCities.insert(locationCity, at: 0)
                self.delegate?.configurePageController(with: allCities)
            }
            
        }
    }
    
    
}
