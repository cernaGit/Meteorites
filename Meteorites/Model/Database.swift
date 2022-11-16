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

    mutating func setDistance(locationTo: CLLocation?) {
        guard let locat = locationTo else {
            return
        }
        
        let pointLocation = CLLocation(latitude: (self.reclat)?.toDouble() ?? 0.0, longitude: (self.reclong)?.toDouble() ?? 0.0)
        self.distance = pointLocation.distance(from: locat)
    }
    
    func getDistance() -> Double? {
        return self.distance
    }
    
    func getDistanceString() -> String? {
        guard var distanceInMeters = distance else {
            return nil
        }
        
        if distanceInMeters >= 1000 {
            let distanceInKm = distanceInMeters / 1000
            return String(format: "%.01f km", distanceInKm)
        }
        
        distanceInMeters.round()
        
        return "\(Int(distanceInMeters)) m"
    }
    
    // MARK: Sort Array
    func sortedArrayByDistance(array: [Meteorites]) -> [Meteorites] {
        var arraySorted = array
        
        arraySorted.sort(by: {
            guard let first = $0.getDistance(), let second = $1.getDistance() else {
                return false
            }
            
            return first < second
        })
        
        return arraySorted
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
