//
//  MeteoritesListViewModel.swift
//  Meteorites
//
//  Created by Kateřina Černá on 11.11.2022.
//

import SwiftUI
import CoreLocationUI
import MapKit

class MeteoritesListViewModel {
    @State var meteorites : [Meteorites] = []
    @Published var userLocation = CLLocation()
    
}


