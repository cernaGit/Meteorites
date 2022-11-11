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

    enum CodingKeys: String, CodingKey {
        case name, id, nametype, recclass, mass, fall, year, reclat, reclong, geolocation
        case computedRegionCbhkFwbd = ":@computed_region_cbhk_fwbd"
        case computedRegionNnqa25F4 = ":@computed_region_nnqa_25f4"
    }
    
    var location: CLLocation {
        return CLLocation(latitude: (self.reclat)?.toDouble() ?? 0.0, longitude: (self.reclong)?.toDouble() ?? 0.0)
    }

    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}

enum Fall: String, Codable {
    case fell = "Fell"
    case found = "Found"
}

struct Geolocation: Codable {
    let latitude, longitude: String
}

enum Nametype: String, Codable {
    case valid = "Valid"
}

typealias Meteor = [Meteorites]
