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
    @State var isModal: Bool = false
    @ObservedObject private var locationManager = LocationManager()
    @State var mapView = MKMapView()
    @State private var cancellable: AnyCancellable?
    private func setCurrentLocation() {
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        }
    }
    
    
    @State private var meteorites: [Meteorites] = []
    private func readJSON() {
        
        guard let mapUrl = URL(string: "https://data.nasa.gov/resource/gh4g-9sfh.json") else { return }
        URLSession.shared.dataTask(with: mapUrl) { (data, response, error) in
            if error == nil {
                do {
                    let parResult = try JSONDecoder().decode([Meteorites].self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.meteorites = parResult
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
                                    CLLocationCoordinate2D(latitude: (meteorites.reclat! as NSString).doubleValue, longitude: (meteorites.reclong! as NSString).doubleValue)
                    ){
                        VStack {
                            Group {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: 30.0, height: 30.0)
                                Circle()
                                    .frame(width: 8.0, height: 8.0)
                            }
                            .foregroundColor(.red)
                            Text(meteorites.name)
                        }
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
    
    

           

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
