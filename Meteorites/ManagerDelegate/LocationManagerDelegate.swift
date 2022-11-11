//
//  LocationManagerDelegate.swift
//  Meteorites
//
//  Created by Kateřina Černá on 10.11.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var lastLocation: CLLocation?
    @Published var locationStatus: CLAuthorizationStatus?

    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        
        DispatchQueue.main.async {
            self.location = location
        }
        
    }
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
    }
    
    func setupLocationManger()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationSevices()
    {
        if CLLocationManager.locationServicesEnabled()
        {
            setupLocationManger()
            checkLocationAuthorizatiob()
        }
        else
        {

        }
    }
    func checkLocationAuthorizatiob()
    {
        switch CLLocationManager.authorizationStatus()
        {
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break

         default:
            break
        }
    }
    
}

