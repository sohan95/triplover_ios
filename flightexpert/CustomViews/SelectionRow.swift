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
        Button {
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
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack() {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.black)
                        Text("\(airport.name) (\(airport.iata))")
                            .foregroundColor(Color.black)
                    }
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    
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
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5)
            )
            .padding(.horizontal, 10) 
        }
    }
}

struct SelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SelectionRow(airport: AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT"),
                     selectedAirport: .constant(AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT")))
    }
}

