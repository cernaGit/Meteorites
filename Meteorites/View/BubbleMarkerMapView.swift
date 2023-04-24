//
//  BubbleMarkerMapView.swift
//  Meteorites
//
//  Created by Kateřina Černá on 12.11.2022.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct BubbleMarkerMapView: View {
    
    @State private var showTitle = true
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    
    let name, recclass: String
    let distance: Double
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy'_'HH:mm:ss.SSS"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack (spacing: 10){
                VStack(spacing: 5) {
                    HStack {
                        Text("Name:")
                        Text("\(name)").bold()
                    }
                    HStack {
                        Text("Class:")
                        Text("\(recclass)").bold()
                    }
                    HStack {
                        Text("Distance:")
                        Text(String(format: "%.0f km", distance)).bold()
                    }
                }
                .font(.caption)
            }
            .padding()
            .background(.white)
            .cornerRadius(30)
            .opacity(showTitle ? 0 : 1)
            
            Image("meteor_icon")
                .resizable()
                .frame(width: 30.0, height: 30.0)
                .foregroundColor(.black)
        }
        .buttonStyle(PlainButtonStyle())
        .tappable {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
    }
}
