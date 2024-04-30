//
//  LocationService.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import UIKit
import Combine
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    @Published private var placemark: CLPlacemark?
    private var subscriptions = Set<AnyCancellable>()
    private var locationManager: CLLocationManager!
        
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestLocation()
    }
    
    func getPlacemark() async -> CLPlacemark {
        return await Future<CLPlacemark, Never>() { [self] promise in
            $placemark.sink { value in
                guard let sinkValue = value else { return }
                promise(.success(sinkValue))
            }.store(in: &subscriptions)
        }.value
    }
        
    // MARK: - Internal
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
//        switch status {
//        case .notDetermined: print("notDetermined")
//            
//        case .restricted: print("restricted")
//            
//        case .denied: print("denied")
//            
//        case .authorizedAlways: print("authorizedAlways")
//         
//        case .authorizedWhenInUse: print("authorizedWhenInUse")
//            
//        case .authorized: print("authorized")
//        
//        default: print("Nan")
//        }
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                self.placemark = placemark
            }
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}

