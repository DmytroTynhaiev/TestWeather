//
//  LocationService.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined: print("notDetermined")
            
        case .restricted: print("notDetermined")
            
        case .denied: print("notDetermined")
            
        case .authorizedAlways: print("notDetermined")
         
        case .authorizedWhenInUse: print("notDetermined")
            
        case .authorized: print("notDetermined")
        
        default: print("Nan")
        }
        

    }
}
