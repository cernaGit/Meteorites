//
//  MapView.swift
//  Meteorites
//
//  Created by Kateřina Černá on 10.11.2022.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct MapView: View {
    var viewModelKit = MapViewModel()
    @State private var region = MKCoordinateRegion.defaultRegion

    
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Map
                //MapViewModel()
                Map(coordinateRegion: $region)

            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}
    
    

           

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
