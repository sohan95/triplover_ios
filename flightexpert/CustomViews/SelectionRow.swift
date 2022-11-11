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
                VStack(alignment: .leading, spacing: 1) {
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
            .padding(.leading, 50)
            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 5)
//                    .fill(Color(hex: "#F9F9F9"))
//                .padding([.leading, .trailing], 10)
//            )
            .frame(minWidth: 0, maxWidth: .infinity)
//            .padding()
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5)
            )
            .padding(.horizontal,10)
            
//            .frame(maxWidth:.infinity, maxHeight: 400)
            
            
        }
    }
}

struct SelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SelectionRow(airport: AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT"),
                     selectedAirport: .constant(AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT")))
    }
}

