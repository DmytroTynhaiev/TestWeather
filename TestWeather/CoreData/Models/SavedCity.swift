//
//  SavedCity.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import Foundation
import CoreData

@objc(SavedCity)
class SavedCity: NSManagedObject {
    
    @NSManaged var city: String
    @NSManaged var lat: String
    @NSManaged var lng: String
    @NSManaged var country: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedCity> {
        let request = NSFetchRequest<SavedCity>(entityName: "SavedCity")
        return request
    }
    
    convenience init(from city: City) {
        self.init(context: TestWeatherPersistenceController.context)
        self.city = city.city
        self.lat = city.lat
        self.lng = city.lng
        self.country = city.country
    }
}
