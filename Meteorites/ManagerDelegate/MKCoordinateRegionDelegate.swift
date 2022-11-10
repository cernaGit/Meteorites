//
//  MKCoordinateRegionDelegate.swift
//  Meteorites
//
//  Created by Kateřina Černá on 10.11.2022.
//

import MapKit

extension MKCoordinateRegion {
    
    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 29.72, longitude: -95.39),
                                                       latitudinalMeters: 1000000, longitudinalMeters: 800000)
    }
    
}
