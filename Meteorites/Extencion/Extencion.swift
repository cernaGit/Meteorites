//
//  Extencion.swift
//  Meteorites
//
//  Created by Kateřina Černá on 11.11.2022.
//

import MapKit
import SwiftUI

extension String
{
    public func toDouble() -> Double?
    {
       if let num = NumberFormatter().number(from: self) {
                return num.doubleValue
            } else {
                return nil
            }
     }
    
    func toDate(dateFormat: String) -> Date? {

      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = dateFormat

      let date: Date? = dateFormatter.date(from: self)
      return date
  }
}

public struct UltraPlainButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

struct Tappable: ViewModifier {
    let action: () -> ()
    func body(content: Content) -> some View {
        Button(action: self.action) {
            content
        }
        .buttonStyle(UltraPlainButtonStyle())
    }
}

extension View {
    func tappable(do action: @escaping () -> ()) -> some View {
        self.modifier(Tappable(action: action))
    }
}

