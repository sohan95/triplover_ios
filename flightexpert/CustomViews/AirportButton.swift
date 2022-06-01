//
//  AirportButton.swift
//  flightexpert
//
//  Created by sohan on 5/27/22.
//

import SwiftUI

struct AirportButton: View {
    var airport: AirportData
//    var iata: String
//    var name: String
//    var country: String
    
    var body: some View {
        VStack(spacing:10) {
            Text(airport.iata)
                .font(.headline)
                .foregroundColor(Color.black)
            HStack{
                Text(airport.name)
                    .font(.caption2)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundColor(Color.black)
//                Text(airport.country)
//                    .font(.caption2)
//                    .fontWeight(.regular)
//                    .multilineTextAlignment(.leading)
//                    .lineLimit(1)
//                    .foregroundColor(Color.black)
            }
            .font(.system(size: 11))
        }
        .buttonStyle(.bordered)
        .frame(width: 80, height: 60)
        .padding(5)
        .background(Color(red: 197/255, green: 213/255, blue: 226/255))
        .cornerRadius(5)
        .shadow(color: .gray, radius: 5, x: 0.1, y: 0.1)
    }
}

struct AirportButton_Previews: PreviewProvider {
    static var previews: some View {
        AirportButton(airport: AirportData(name: "Dhaka", city: "Dhaka", country: "Bangladesh", iata: "DHK"))
    }
}
