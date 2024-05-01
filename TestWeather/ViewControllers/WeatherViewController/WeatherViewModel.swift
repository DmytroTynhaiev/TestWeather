//
//  WeatherViewModel.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import Foundation

class WeatherViewModel {
    
    var locationService = LocationService()
    weak var delegate: WeatherViewControllerDelegate?
    
    func fetchWeather() {
        Task {
            
            let placemark = await locationService.getPlacemark()
  
            let name = placemark.locality ?? "NAN"
            let latitude = placemark.location?.coordinate.latitude ?? 0.0
            let longitude = placemark.location?.coordinate.longitude ?? 0.0
            let country = placemark.country ?? "NAN"
            let city = City(city: name, lat: "\(latitude)", lng: "\(longitude)", country: country)
            
             
            let path = "https://api.open-meteo.com/v1/forecast"
            let params = [
                "latitude" : latitude,
                "longitude" : longitude,
                "current" : "temperature_2m,wind_speed_10m"
            ]
            

            NetworkService.shared.request(path: path, method: .get, parameters: params ,decadable: Weather.self) { response in

                self.delegate?.setWeather(city, response)
                
            } failure: { error in
                print(error.localizedDescription)
            }
            
        }
    
    }

}
