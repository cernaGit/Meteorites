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

    
    let name, recclass, destination: String
    @State var showDetail : Bool = false

    
    var body: some View {
        VStack(spacing: 0) {
            VStack (spacing: 10){
                VStack(spacing: 8) {
                    Text("Název: \(name)").bold()
                    Text("Třída: \(recclass)").bold()
                }
                VStack (spacing: 8) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("rok").bold()
                    }
                    Text("Vzdálenost: \(destination) km")
                        .font(.body)
                        .fontWeight(.bold)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                }
                Spacer()
            }
            .padding().background(.white).cornerRadius(30)
            
            .opacity(showTitle ? 0 : 1)
            
            Image(systemName: "flame.circle.fill")
                .resizable()
                .frame(width: 30.0, height: 30.0)
                .foregroundColor(.black)

            
        }.buttonStyle(PlainButtonStyle())
        .tappable {
                withAnimation(.easeInOut) {
                    showTitle.toggle()

                }
            }
    }
}
