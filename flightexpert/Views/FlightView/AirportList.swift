//
//  AirportList.swift
//  flightexpert
//
//  Created by sohan on 5/28/22.
//

import SwiftUI

struct AirportList: View {
    
    @Environment(\.presentationMode) var presentationMode
    typealias Action = (AirportData) -> Void
    var action: Action?
    
    let airportList = AirportDataLoader().airportList
    @State var selectedAirport: AirportData?
    
    @State private var searchText = ""
    @State var searching = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $searchText, searching: $searching)
            List {
                ForEach(airportList.filter({ (airport: AirportData) -> Bool in
                    return airport.iata.hasPrefix(searchText) ||
                    airport.name.hasPrefix(searchText) ||
                    airport.city.hasPrefix(searchText) || searchText == ""
                }), id: \.self) { airport in
                    //Text(airport.iata)
                    SelectionRow(airport: airport, selectedAirport: $selectedAirport) {airport in
                        print(airport)
                        DismissSheet()
                    }
                }
            }
            .listStyle(GroupedListStyle())
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

//struct AirportList_Previews: PreviewProvider {
//    static var previews: some View {
//        AirportList(selectedModel: RandomModel(title: "source", iata: "BAB"))
//        //        AirportList(selectedAirport: .constant(AirportData(name: "Sylhet", city:"Sylhet", country: "Bangladesh", iata: "SLT")))
//    }
//}

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
                    TextField("Search ..", text: $searchText) { startedEditing in
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

