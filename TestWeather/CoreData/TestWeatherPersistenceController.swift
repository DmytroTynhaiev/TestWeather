//
//  TestWeatherPersistenceController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import Foundation
import CoreData

struct TestWeatherPersistenceController {
    
    private static var shared = TestWeatherPersistenceController()
    static var context = Self.shared.container.viewContext
    let container: NSPersistentContainer
    
    private init() {
        self.container = NSPersistentContainer(name: "TestWeather")
        self.container.loadPersistentStores {  description, error in
            if let error = error {
                print("Error: ", error.localizedDescription)
            }
            
            print("Desctiption: ", description)
        }
    }
    
    static func save() {
        if Self.context.hasChanges {
            do {
                try Self.context.save()
            } catch let error {
                print("Error: ", error.localizedDescription)
            }
        }
    }
    
    static func delete(_ object: NSManagedObject) {
        Self.context.delete(object)
        Self.save()
    }
    
}
