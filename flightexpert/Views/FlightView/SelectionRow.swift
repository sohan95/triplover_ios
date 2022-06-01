//
//  SelectionRow.swift
//  SwiftUI5BuildingBlock
//
//  Created by sohan on 5/26/22.
//

import SwiftUI

struct SelectionRow: View {
//    typealias Action = (AirportData) -> Void
    
    let airport: AirportData
    @Binding var selectedAirport: AirportData?
//    var action: Action?
    
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                VStack(spacing:10) {
                    HStack() {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.accentColor)
                        Text("\(airport.name) (\(airport.iata))")
                            .font(.headline)
                    }
                    HStack {
                        Text("\(airport.city), ")
                        Text(airport.country)
                    }
                    .padding(.leading)
                }
                
                
                Spacer()
                if airport.iata == selectedAirport?.iata {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                        .padding()
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                // tap
                if airport.iata == selectedAirport?.iata {
                    selectedAirport = nil
                } else {
                    selectedAirport = airport
                }
                
    //            // action
    //            if let action = action {
    //                action(airport)
    //            }
            }
        }
    }
}

struct SelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SelectionRow(airport: AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT"),
                     selectedAirport: .constant(AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT")))
    }
}

