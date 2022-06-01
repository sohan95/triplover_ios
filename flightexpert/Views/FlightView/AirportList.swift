//
//  AirportList.swift
//  flightexpert
//
//  Created by sohan on 5/28/22.
//

import SwiftUI

struct AirportList: View {
    
    @Environment(\.presentationMode) var presentationMode
    var selectedModel: RandomModel
    
    typealias Action = (AirportData) -> Void
    var action: Action?
    
    let data = AirportDataLoader().airportList
    @State var selectedAirport: AirportData?
    
    var body: some View {
        ZStack {
            
            backgroundGradient
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(alignment: .leading) {
                Button(action: {
                    
                    guard selectedAirport != nil else {
                        presentationMode.wrappedValue.dismiss()
                        return
                    }
                    
                    let airport = AirportData(name: selectedAirport!.name,
                                              city: selectedAirport!.city,
                                              country: selectedAirport!.country,
                                              iata: selectedAirport!.iata)
                    // action
                    if let action = action {
                        action(airport)
                    }
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(20)
                })

                List {
                    ForEach(data, id:\.self) { airport in
                        SelectionRow(airport: airport, selectedAirport: $selectedAirport)
                            .padding()
    //                    {airport in
    //                        print(airport)
                            // action
    //                        if let action = action {
    //                            action(airport)
    //                        }
    //                        presentationMode.wrappedValue.dismiss()
    //                    }
                    }
                    
                }
            }
        }
        
    }
}

struct AirportList_Previews: PreviewProvider {
    static var previews: some View {
        AirportList(selectedModel: RandomModel(title: "source", iata: "BAB"))
//        AirportList(selectedAirport: .constant(AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT")))
    }
}

