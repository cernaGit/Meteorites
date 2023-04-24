//
//  MeteoritesList.swift
//  Meteorites
//
//  Created by Kateřina Černá on 11.11.2022.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct MeteoritesListView: View {
    
    var fetch = MeteoritesListViewModel()
    @State private var meteorites : [Meteorites] = []
    @ObservedObject private var locationManager = LocationManager()
    @State private var userLocation: CLLocation?
    @State private var searchText = ""
    
    var sortedMeteorites: [Meteorites] {
        meteorites
            .filter {
                searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
            }
            .sorted { meteorite1, meteorite2 in
                if let userLocation = userLocation {
                    let location1 = CLLocation(latitude: Double(meteorite1.geolocation!.latitude)!, longitude: Double(meteorite1.geolocation!.longitude)!)
                    let location2 = CLLocation(latitude: Double(meteorite2.geolocation!.latitude)!, longitude: Double(meteorite2.geolocation!.longitude)!)
                    return location1.distance(from: userLocation) < location2.distance(from: userLocation)
                } else {
                    return meteorite1.name < meteorite2.name
                }
            }
    }
    
    func getJSONList(completion:@escaping ([Meteorites]) -> ()) {
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
        VStack {
            SearchBar(searchText: $searchText)
            
            List(sortedMeteorites) { meteorite in
                HStack {
                    ListRowMeteoritesView(name: meteorite.name, recclass: meteorite.recclass, year: meteorite.year!, mass: meteorite.mass ?? "Invalid value")
                        .listRowSeparator(.automatic)
                }
            }
            .onAppear() {
                getJSONList()
                {
                    (meteorites) in
                    self.fetch.meteorites = meteorites
                }
            }
        }
    }
}
