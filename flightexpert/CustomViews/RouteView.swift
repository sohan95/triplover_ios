//
//  RouteView.swift
//  flightexpert
//
//  Created by sohan on 5/27/22.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let iata: String
}

//struct OneWayRoute: View {
//    @State var selectedModel: RandomModel? = nil
////    @State var showAirportList: Bool = false
//
//    @Binding var source: AirportData
//    //= AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
//    @Binding var destination: AirportData
//    //= AirportData(name: "Aalborg", city: "Aalborg", country:"Denmark", iata: "AAL")
//
//    @Binding var selectedDate: Date
//
//    var body: some View {
//        HStack (spacing: 10) {
//            //Source
//            Button {
//                //showAirportList.toggle()
//                selectedModel = RandomModel(title:"source", iata: source.iata)
//
//            } label: {
//                AirportButton(airport: source)
////                Text("Button=\(self.destination!.iata)")
//
//            }
//
//            Image(systemName: "airplane")
//
//            Button {
////                showAirportList.toggle()
//                selectedModel = RandomModel(title: "destination", iata: destination.iata)
//            } label: {
//                AirportButton(airport: destination)
////                Text("Button=\(self.source!.iata)")
//            }
//            //            .sheet(isPresented: $showAirportList, content: {
//            //                AirportList(selectedAirport: $source)
//            //            })
////            .sheet(isPresented: $showAirportList) {
////                //                route.origin = source!.iata
////                //                route.destination = destination!.iata
////                print("source=\(source!) and Destin=\(destination!)")
////            } content: {
////                AirportList(){airport in
////                    print(airport)
////                    source = airport
////                }
////            }
//
////            Image(systemName: "airplane")
////
////            // Destination
////            Button {
////                showAirportList.toggle()
////            } label: {
////                AirportButton(airport: destination!)
////            }
////            //            .sheet(isPresented: $showAirportList, content: {
////            //                AirportList(selectedAirport: $destination)
////            //            })
////            .sheet(isPresented: $showAirportList) {
////                //                route.origin = source!.iata
////                //                route.destination = destination!.iata
////                //                print(route)
////            } content: {
////                AirportList(){airport in
////                    print(airport)
////                    destination = airport
////                }
////            }
//
//
//            Button {
//            } label: {
//                DepartureDateButton(selectedDate: $selectedDate)
//            }
//        }
//        .padding(5)
//        .sheet(item: $selectedModel) { model in
//            AirportList() { airport in
//                if (selectedModel?.title == "source") {
//                    source = airport
//                    print("source=\(airport)")
//                } else if (selectedModel?.title == "destination") {
//                    destination = airport
//                    print("Destination=\(airport)")
//                }
//            }
//        }
//    }
//}

//struct AirportListSheet: View {
//    @Environment(\.presentationMode) var presentationMode
//
//    var selectedModel: RandomModel
//
////    var airport: AirportData
//    typealias Action = (AirportData) -> Void
//    var action: Action?
//
//    var body: some View {
//        Text(selectedModel.title)
//
//        Button {
//
//            let airport = AirportData(name: selectedModel.title, city: "Dhaka", country: "Dhaka", iata: "Dhaka")
//            // action
//            if let action = action {
//                action(airport)
//            }
//            presentationMode.wrappedValue.dismiss()
//        } label: {
//            Text("Change")
//        }
//
//
//    }
//}

//struct DepartureDateButton: View {
//    @Binding var selectedDate: Date
//
//    var body: some View {
//        VStack(spacing:10){
//            Text("Departure Date")
//                .font(.system(size: 12))
//                .foregroundColor(Color.primary)
//            DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
//        }
//        .frame(width: 120, height: 70)
//        .cornerRadius(5)
//    }
//}

//struct RouteView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let source = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
//        let destination = AirportData(name: "Aalborg", city: "Aalborg", country:"Denmark", iata: "AAL")
//
//        OneWayRoute(source: .constant(source), destination: .constant(destination), selectedDate: .constant(Date()))
//        //RouteView(route: .constant(Route(origin: "DHK", destination: "RAJ", departureDate: "25-07-2022")))
//    }
//}

struct RoutePointButton: View {
    @State var selectedModel: RandomModel? = nil
    @Binding var source: AirportData
    
    var body: some View {
        Button {
            selectedModel = RandomModel(title:"source", iata: source.iata)
        } label: {
            VStack(alignment:.leading, spacing: 5){
                Text("From")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                Text(source.iata)
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .foregroundColor(.black)
                Text("Click to search")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
            }
            .padding(5)
        }
        .frame(minWidth:0, maxWidth: .infinity,minHeight: 80, maxHeight: 80)
        .background(.white)
        .addBorder(Color.gray, width: 2, cornerRadius: 10)
        .sheet(item: $selectedModel) { model in
            AirportList() { airport in
                source = airport
                print("source=\(airport)")
            }
        }
    }
}

struct RoutePointButton_Previews: PreviewProvider {
    static var previews: some View {
        let source = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
        RoutePointButton(source: .constant(source))
    }
}
