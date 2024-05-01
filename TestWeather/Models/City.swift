//
//  City.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import Foundation

class City: Codable {
    
    var city: String
    var cityASCII: String
    var lat: String
    var lng: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case city, lat, lng, country
        case cityASCII = "city_ascii"
    }
    
    init(city: String, lat: String, lng: String, country: String) {
        self.city = city
        self.lat = lat
        self.lng = lng
        self.country = country
        self.cityASCII = ""
    }
    
    convenience init(from savedCity: SavedCity)  {
        self.init(city: savedCity.city,
                  lat: savedCity.lat,
                  lng: savedCity.lng,
                  country: savedCity.country)
    }

}
