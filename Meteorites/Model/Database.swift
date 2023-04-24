//
//  Database.swift
//  Meteorites
//
//  Created by Kateřina Černá on 10.11.2022.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct Meteorites: Codable, Identifiable {
    let name, id: String
    let nametype: Nametype
    let recclass: String
    let mass: String?
    let fall: Fall
    let year, reclat, reclong: String?
    let geolocation: Geolocation?
    let computedRegionCbhkFwbd, computedRegionNnqa25F4: String?
    private var distance: Double?

    enum CodingKeys: String, CodingKey {
        case name, id, nametype, recclass, mass, fall, year, reclat, reclong, geolocation
        case computedRegionCbhkFwbd = ":@computed_region_cbhk_fwbd"
        case computedRegionNnqa25F4 = ":@computed_region_nnqa_25f4"
    }
}

enum Fall: String, Codable {
    case fell = "Fell"
    case found = "Found"
}

struct Geolocation: Codable {
    let latitude, longitude: String
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
    }
}

enum Nametype: String, Codable {
    case valid = "Valid"
}

typealias Meteor = [Meteorites]
