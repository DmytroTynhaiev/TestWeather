//
//  WeatherViewModel.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import Foundation

class WeatherViewModel {
    
    weak var delegate: WeatherViewControllerDelegate?
    
    func fetchWeather() {
        let path = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m"
        NetworkService.shared.request(path: path, method: .get, decadable: Weather.self) { response in

            self.delegate?.setWeather(response)
            
        } failure: { error in
            print(error.localizedDescription)
        }

    }
    
    
    
}
