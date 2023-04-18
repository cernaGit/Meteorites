//
//  ListRowMeteoritesView.swift
//  Meteorites
//
//  Created by Kateřina Černá on 29.11.2022.
//

import SwiftUI

struct ListRowMeteoritesView: View {
    
    let name, recclass, year: String
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Image("meteor_icon")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                
                Spacer()
                
                Text(String("\(name)"))
                    .font(.title2)
                    .bold()
                
                Spacer()
            }
            .padding()
            .foregroundColor(.red)
            .background(.black)
            .cornerRadius(30)
            
            HStack {
                VStack(alignment:.leading ,spacing: 5) {
                    Text("Třída:  \(recclass) ")
                        .bold()
                    
                    HStack {
                        Image(systemName: "calendar")
                        
                        if let date = dateFormatter.date(from: year) {
                            Text(dateFormatter.string(from: date))
                                .font(.subheadline)
                        } else {
                            Text("Invalid Date")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
            }
        }
        .foregroundColor(.black)
        .cornerRadius(30)
    }
}

