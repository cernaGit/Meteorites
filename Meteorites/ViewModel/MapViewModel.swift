//
//  MapViewModel.swift
//  Meteorites
//
//  Created by Kateřina Černá on 10.11.2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapViewModel: UIViewRepresentable {
    func updateUIView(_ view: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 29.726819, longitude: -95.393692), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        view.setRegion(region, animated: true)
    }
    
    
    @State var mapView = MKMapView()
    @State var locationManager: CLLocationManager!
    @State private var meteorites : [Meteorites] = []

    
    func makeUIView(context: Context) -> MKMapView {
        self.locationManager.requestAlwaysAuthorization()
        return mapView
    }
}
