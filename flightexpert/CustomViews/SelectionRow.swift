//
//  SelectionRow.swift
//  SwiftUI5BuildingBlock
//
//  Created by sohan on 5/26/22.
//

import SwiftUI

struct SelectionRow: View {
    typealias Action = (AirportData) -> Void
    
    let airport: AirportData
    @Binding var selectedAirport: AirportData?
    var action: Action?
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
                    Image(systemName: "airplane.departure")
                        .foregroundColor(.gray)
                    Text("\(airport.name) (\(airport.iata))")
                }.font(.system(size: 14, weight: .bold, design: .rounded))
                
                Text("\(airport.city), \(airport.country)")
                .font(.system(size: 11, weight: .regular, design: .rounded))
                .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            if airport.iata == selectedAirport?.iata {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
                    .padding()
            }
        }
        .padding(5)
        .onTapGesture {
            // tap
            if airport.iata == selectedAirport?.iata {
                selectedAirport = nil
            } else {
                selectedAirport = airport
                
                // action
                if let action = action {
                    action(airport)
                }
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

