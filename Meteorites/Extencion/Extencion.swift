//
//  Extencion.swift
//  Meteorites
//
//  Created by Kateřina Černá on 11.11.2022.
//

import MapKit

extension String
{
    /// EZSE: Converts String to Double
    public func toDouble() -> Double?
    {
       if let num = NumberFormatter().number(from: self) {
                return num.doubleValue
            } else {
                return nil
            }
     }
}

extension Array where Element == Meteorites {

    mutating func sort(by location: CLLocation) {
         return sort(by: { $0.distance(to: location) < $1.distance(to: location) })
    }

    func sorted(by location: CLLocation) -> [Meteorites] {
        return sorted(by: { $0.distance(to: location) < $1.distance(to: location) })
    }
}
