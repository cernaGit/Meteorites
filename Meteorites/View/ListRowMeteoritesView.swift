//
//  ListRowMeteoritesView.swift
//  Meteorites
//
//  Created by Kateřina Černá on 29.11.2022.
//

import SwiftUI

struct ListRowMeteoritesView: View {
    
    let name, recclass, year: String
    let mass: String
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter
    }()
    private let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Image("meteor_icon")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                    .padding()
                HStack {
                    VStack(alignment:.leading ,spacing: 5) {
                        Text(String("\(name)"))
                            .font(.headline)
                            .bold()
                        
                        HStack {
                            Text("Class:")
                            Text("\(recclass) ")
                                .bold()
                        }
                        .font(.subheadline)
                        
                        HStack {
                            Text("Mass:")
                            Text("\(mass) ")
                                .bold()
                        }
                        .font(.subheadline)

                        HStack {
                            Image(systemName: "calendar")
                            
                            if let date = dateFormatter.date(from: year) {
                                Text(displayDateFormatter.string(from: date))
                            } else {
                                Text("Invalid Date")
                                    .foregroundColor(.red)
                            }
                        }
                        .font(.subheadline)

                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .foregroundColor(.black)
        .cornerRadius(30)
    }
}

