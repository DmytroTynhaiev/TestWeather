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
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func getPlacemark() async -> CLPlacemark? {
        return await Future<CLPlacemark?, Never>() { [self] promise in
            $placemark.dropFirst().sink { value in
                promise(.success(value))
            }.store(in: &subscriptions)
        }.value
    }
        
    // MARK: - Internal
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            
        case .authorizedAlways, .authorizedWhenInUse, .authorized, .notDetermined:
            self.locationManager.requestLocation()
            
        case .denied:
            self.placemark = nil
            
        default:
            self.placemark = nil
        }
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
        AppHelper.showError(error)
    }
}

