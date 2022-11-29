//
//  ListRowMeteoritesView.swift
//  Meteorites
//
//  Created by Kateřina Černá on 29.11.2022.
//

import SwiftUI

struct ListRowMeteoritesView: View {
    
    let name, recclass, year, distance: String
    let date = Date()


    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Image(systemName: "globe.europe.africa")
                    .resizable()
                    .frame(width: 20.0, height: 20.0)
                Spacer()
                Text(String("\(name)")).font(.title2).bold()
                Spacer()
            }.padding().foregroundColor(.white).background(.black).opacity(0.7).cornerRadius(30)
            
            HStack {
                VStack(alignment:.leading ,spacing: 5) {
                    Text("Třída: \(recclass) ").bold()
                    HStack {
                        Image(systemName: "calendar")
                        Text(date, style: .date).bold()
                    }
                    Text(String("\(distance) Km"))
                }.padding()
                Spacer()

            }.padding().foregroundColor(.black).background(.black).opacity(0.4).cornerRadius(30)
        }
    }
}

