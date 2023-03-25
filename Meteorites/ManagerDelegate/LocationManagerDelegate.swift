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
    let manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation?
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            self.lastKnownLocation = location
        }

        func distance(to location: CLLocation) -> CLLocationDistance? {
            guard let userLocation = self.lastKnownLocation else { return nil }
            return location.distance(from: userLocation)
        }

        func distance(to meteorite: Meteorites) -> CLLocationDistance? {
            guard let lat = Double(meteorite.geolocation!.latitude), let long = Double(meteorite.geolocation!.longitude) else { return nil }
            let location = CLLocation(latitude: lat, longitude: long)
            return self.distance(to: location)
        }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func requestLocation() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
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
        switch manager.authorizationStatus {
        case .restricted, .denied:
                break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

