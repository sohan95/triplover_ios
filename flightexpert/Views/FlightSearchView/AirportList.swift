//
//  AirportList.swift
//  flightexpert
//
//  Created by sohan on 5/28/22.
//

import SwiftUI

struct AirportData: Hashable, Codable {
    var name: String
    var city: String
    var country: String
    var iata: String
    var direction: String?
}

struct AirportList: View {
    typealias Action = (AirportData) -> Void
    var action: Action?
    
    // Locat vars
    @Environment(\.presentationMode) var presentationMode
    @State var airportList = [AirportData]()
    @State var selectedAirport: AirportData?
    @State private var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBar(searchText: $searchText, searching: $searching)
                ScrollView {
                    LazyVStack(spacing: 2) {
                        ForEach(airportList.filter({ (airport: AirportData) -> Bool in
                            return airport.iata.lowercased().hasPrefix(searchText.lowercased()) ||
                            airport.name.lowercased().hasPrefix(searchText.lowercased()) ||
                            airport.city.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""
                        }), id: \.self) { airport in
                            SelectionRow(airport: airport, selectedAirport: $selectedAirport) {airport in
                                print(airport)
                                DismissSheet()
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Airport List")
        }
        .onAppear {
            airportList = AirportDataLoader().airportList
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
        AirportList(){ row in
            //
        }
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("mercaryColor"))
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search...", text: $searchText) { startedEditing in
                        if startedEditing {
                            withAnimation {
                                searching = true
                            }
                        }
                    } onCommit: {
                        withAnimation {
                            searching = false
                        }
                    }
                    
                }
                .foregroundColor(.gray)
                .padding(.leading, 13)
            }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
            if searching {
                Button("Cancel") {
                    searchText = ""
                    withAnimation {
                       searching = false
                       UIApplication.shared.dismissKeyboard()
                    }
                }
                .padding(.trailing, 10)
            }
        }
    }
}

extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }

