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
    
    init(city: String, lat: String, lng: String) {
        self.city = city
        self.lat = lat
        self.lng = lng
        self.cityASCII = ""
        self.country = ""
    }

}
