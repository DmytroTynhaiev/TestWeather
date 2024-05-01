//
//  WeatherViewModel.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import Foundation

class WeatherViewModel {
    
    weak var delegate: WeatherViewControllerDelegate?
    
    func fetchWeather(for city: City) {
        
        let path = "https://api.open-meteo.com/v1/forecast"
        let params = [
            "latitude" : city.lat,
            "longitude" : city.lng,
            "current" : "temperature_2m,wind_speed_10m"
        ]
    
        NetworkService.shared.request(path: path, method: .get, parameters: params ,decadable: Weather.self) { response in
            
            self.delegate?.setWeather(city, response)
            
        } failure: { error in
            print(error.localizedDescription)
        }
                
    }
    
}
