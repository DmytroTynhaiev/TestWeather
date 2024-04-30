//
//  WeatherinfoView.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import UIKit

class WeatherinfoView: UIView {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    static func loadView() -> WeatherinfoView {
        return Bundle.main.loadNibNamed("WeatherinfoView", owner: nil)?.last as! WeatherinfoView
    }
    
    func setInfo(_ city: City, _ weather: Weather) {
        let cityName = city.city
        let temperature = Int(weather.temperature)
        let windSpeed = Int(weather.windSpeed)
        
        self.cityLabel.text = cityName
        self.degreeLabel.text = "\(temperature)°"
        self.windLabel.text = "\(windSpeed) km/h"
    }
}
