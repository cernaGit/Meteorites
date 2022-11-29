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
    private var deviceLocation: CLLocation?

    
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
            List(meteorites) { todo in
                HStack {
                    ListRowMeteoritesView(name: todo.name, recclass: todo.recclass,year: String(todo.year!), distance: String(todo.getDistance() ?? 0.0))
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

struct MeteoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        MeteoritesListView()
    }
}
