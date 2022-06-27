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
    
    let airportList = AirportDataLoader().airportList
    @State var selectedAirport: AirportData?
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    ForEach(searchResults, id:\.self) { airport in
                        SelectionRow(airport: airport, selectedAirport: $selectedAirport) {airport in
                                print(airport)
                                DismissSheet()
                            }
                    }.padding()
                    
                }
                .padding(.top, 10)
                .searchable(text: $searchText)
                .navigationTitle("\(selectedModel.title) Airports")
                .navigationBarItems(
                    leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                    })
                )
            }
        }
        
    }
    
    var searchResults: [AirportData] {
        if searchText.isEmpty {
            return airportList
        } else {
            return airportList.filter { $0.iata.contains(searchText) }
        }
    }
    
    func DismissSheet() {
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
    }
}

struct AirportList_Previews: PreviewProvider {
    static var previews: some View {
        AirportList(selectedModel: RandomModel(title: "source", iata: "BAB"))
        //        AirportList(selectedAirport: .constant(AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT")))
    }
}

