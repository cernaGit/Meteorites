//
//  MapView.swift
//  Meteorites
//
//  Created by Kateřina Černá on 10.11.2022.
//

import SwiftUI
import CoreLocationUI
import MapKit
import Combine

struct MapView: View {
    var viewModelKit = MapViewModel()
    @State private var region = MKCoordinateRegion.defaultRegion
    @ObservedObject private var locationManager = LocationManager()
    @State var mapView = MKMapView()
    @State private var cancellable: AnyCancellable?
    private func setCurrentLocation() {
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        }
    }
    
    @State private var meteorites: [Meteorites] = []
    @State var showingAlert : Bool = false
    
    private func readJSON() {
        guard let mapUrl = URL(string: "https://data.nasa.gov/resource/gh4g-9sfh.json") else { return }
        URLSession.shared.dataTask(with: mapUrl) { (data, response, error) in
            if error == nil {
                do {
                    let parResult = try JSONDecoder().decode([Meteorites].self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.meteorites = parResult
                        //print(parResult)
                    }
                } catch let jsonError{
                    print("An error occurred + \(jsonError)")
                }
            }
        }.resume()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Map(coordinateRegion: $region, interactionModes: MapInteractionModes.all,
                    showsUserLocation: true, userTrackingMode: .constant(.none),
                    annotationItems: meteorites)
                {
                    meteorites in
                    MapAnnotation(coordinate:
                                    CLLocationCoordinate2D(latitude: (meteorites.reclat)?.toDouble() ?? 0.0, longitude: (meteorites.reclong)?.toDouble() ?? 0.0)
                    ){
                        BubbleMarkerMapView(name: meteorites.name, recclass: meteorites.recclass)
                            .onTapGesture(count: 1, perform: {
                                self.showingAlert = true
                            })
                    }
                }
            }
            .onAppear{
                setCurrentLocation()
                readJSON()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


