//
//  Weather.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import Foundation

class Weather: Codable {
    
    var temperature: Double
    var windSpeed: Double
    
    enum Nested: String, CodingKey {
          case current
      }
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case windSpeed = "wind_speed_10m"
    }
  
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Nested.self)
        let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .current)
        self.temperature = try nested.decode(Double.self, forKey: .temperature)
        self.windSpeed = try nested.decode(Double.self, forKey: .windSpeed)
    }
}
