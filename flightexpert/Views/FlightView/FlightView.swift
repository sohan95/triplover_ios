//
//  FlightView.swift
//  flightexpert
//
//  Created by sohan on 5/25/22.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color(red: 128/255, green: 173/255, blue: 214/255), Color(red: 254/255, green: 253/255, blue: 253/255),Color(red: 249/255, green: 228/255, blue: 209/255)],
    startPoint: .top, endPoint: .bottom)

struct Route: Encodable {
    let origin: String
    let destination: String
    let departureDate: String
}

struct SearchFlighRequest: Encodable {
    let routes: [Route]
    let adults: Int
    let childs: Int
    let infants: Int
    let cabinClass: Int
    let preferredCarriers: [ Int]
    let prohibitedCarriers: [Int]
    let childrenAges: [Int]
}

struct FlightView: View {
    
    @State var isSearching: Bool = false
    @State var isGotSearchData: String? = nil
    @State var directionList:[Directions] = []
    
    @State var adults: Int = 2
    @State var childs: Int = 1
    @State var infants: Int = 0
    @State var cabinClass: String = "Economy" // cabinClass
    @State var preferredCarriers: [String] = []
    @State var prohibitedCarriers: [String] = []
    @State var childrenAges: [String] = []
    @State var showAirports: Bool = false
    
    @State private var isDirectFlight = false
    
    // Route=OneWay
    @State var oneWaySource: AirportData? = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
    @State var oneWayDestin: AirportData? = AirportData(name: "Aalborg", city: "Aalborg", country:"Denmark", iata: "AAL")
    @State var oneWayDate = Date()
    
    var flightRouteTypes = ["One-Way" ,"Round-Trip", "Multi-city"]
    var cabinClassList = ["Economy" ,"PremiumEconomy", "Business", "First", "PremiumFirst"]
    
    @State var typeSelected: String = "One-Way"
    
    private var isOneWay: Bool {
        return typeSelected == flightRouteTypes[0]
    }
    
    private var isRoundTrip: Bool {
        return typeSelected == flightRouteTypes[1]
    }
    
    private var isMultiCity: Bool {
        return typeSelected == flightRouteTypes[2]
    }
    
    @State var multiCityRouteCount: Int = 2
    
    let columnSpacing: CGFloat = 5
    let rowSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.all, edges: .all)
            NavigationLink(destination: OriginFlightList(message: "Test", directionList: directionList), tag: "A", selection: $isGotSearchData) { EmptyView() }
            if !isSearching {
                VStack {
                
                // TripRouteSegment
                ScrollView([], showsIndicators: false, content: {
                    LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                        
                        ForEach(flightRouteTypes, id: \.self) { type in
                            TripSegmentedView(typeSelected: self.$typeSelected, name: type)
                        }
                    })//: GRID
                    .frame(width: 240, height: 50)
                    .cornerRadius(5)
                    
                })//: SCROLL
                .frame(width: 300, height: 50)
                .background(Color("button-bg-color").cornerRadius(5))
                .padding(.bottom, 30)
                
                if isOneWay {
                    OneWayRoute(source: $oneWaySource, destination: $oneWayDestin, selectedDate: $oneWayDate)
                }
//                if isRoundTrip {
//                    RouteView(route: $roundWayRoutes[0])
//                    RouteView(route: $roundWayRoutes[1])
//                }
//                if isMultiCity {
//                    ForEach(0 ..< multiCityRouteCount, id:\.self) { i in
//                        RouteView(route: $multiCityRoutes[i])
//                    }
//
//                    HStack {
//                        Button {
//                            if multiCityRouteCount < 4 {
//                                multiCityRouteCount += 1
//                            }
//                        } label: {
//                            Label("Add More Trip", systemImage: "plus.square")
//                        }
//
//                        if multiCityRouteCount > 2 {
//                            Button {
//                                if multiCityRouteCount > 2 {
//                                    multiCityRouteCount -= 1
//                                }
//                            } label: {
//                                Label("Remove Trip", systemImage: "minus.square")
//                            }
//                        }
//                    }
//                }
                
                
                Spacer()
                
                VStack(spacing:0) {
                    Divider()
                        .frame(height: 1)
                        .background(Color.red)
                    HStack(alignment: .center, spacing:0) {
                        //firstDiv
                        VStack(spacing:20) {
                            HStack{
                                Button {
                                    if adults<10 {
                                        adults += 1
                                    }
                                } label: {
                                    Image(systemName: "plus.square")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                    
                                }.foregroundColor(.black)
                                
                                Text("\(adults)")
                                
                                Button {
                                    if adults > 0 {
                                        adults -= 1
                                    }
                                } label: {
                                    Image(systemName: "minus.square")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                    
                                }.foregroundColor(.black)
                                
                            }
                            Text("Adult(\(adults)+)")
                                .frame(width: 100)
                        }
                        .padding(20)
                        .frame(width: 130)
                        
                        Divider()
                            .frame(width: 1)
                            .background(Color.red)
                        //MiddleDiv
                        VStack(spacing:20) {
                            HStack{
                                Button {
                                    if childs < 10 {
                                        childs += 1
                                    }
                                } label: {
                                    Image(systemName: "plus.square")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                    
                                }.foregroundColor(.black)
                                
                                Text("\(childs)")
                                
                                Button {
                                    if childs > 0 {
                                        childs -= 1
                                    }
                                } label: {
                                    Image(systemName: "minus.square")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                    
                                }.foregroundColor(.black)
                                
                            }
                            Text("Child(\(childs)+)")
                                .frame(width: 100)
                        }
                        .padding(20)
                        .frame(width: 130)
                        
                        Divider()
                            .frame(width: 1)
                            .background(Color.red)
                        //LaseDiv
                        VStack(spacing:20) {
                            HStack{
                                Button {
                                    if infants<10 {
                                        infants += 1
                                    }
                                } label: {
                                    Image(systemName: "plus.square")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                    
                                }.foregroundColor(.black)
                                
                                Text("\(infants)")
                                
                                Button {
                                    if infants > 0 {
                                        infants -= 1
                                    }
                                } label: {
                                    Image(systemName: "minus.square")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                    
                                }.foregroundColor(.black)
                                
                            }
                            Text("Infant(\(infants)+)")
                                .frame(width: 100)
                        }
                        .padding(20)
                        .frame(width: 130)
                    }
                    .frame(height: 130)
                    Divider()
                        .frame(height: 1)
                        .background(Color.red)
                }
                
                //: CabinClass
                ScrollView([], showsIndicators: false, content: {
                    LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                        
                        ForEach(cabinClassList, id: \.self) { cabinName in
                            CabinSegmentedView(cabinSelected: $cabinClass, name: cabinName)
                        }
                    })//: GRID
                    .frame(width:10, height: 10)
                    .cornerRadius(5)
                    
                })//: SCROLL
                .frame(maxWidth: .infinity, alignment: .trailing)
                .frame(height:70)
                .background(Color(red: 249/255, green: 228/255, blue: 209/255))
                
                //:is Direct Flight
                HStack {
//                    Toggle(isOn: $isDirectFlight) {
//                        //
//                    }.padding()
                    Toggle("Direct Flight", isOn: $isDirectFlight)
                        .padding()
//                    Text("Direct Flight")
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                    Spacer()
                }
                .background(isDirectFlight ? Color.orange : Color(red: 249/255, green: 228/255, blue: 209/255))
                
                //: Search Button
                VStack {
                    Button {
                        self.searchFlight()
                    } label: {
                        Text("Search Flight")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height:60)
                            .foregroundColor(Color.white)
                            .font(.system(size: 24, weight:.heavy))
                    }
                }
                .background(Color.blue)
            }
            }
            if isSearching {
                LoadingView()
            }
            
        }
        .navigationTitle("Flight")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func searchFlight() {
        isSearching = true
        let oneWayRoute: Route = Route(origin: oneWaySource!.iata, destination: oneWayDestin!.iata, departureDate: getDateString(date: oneWayDate))
        print(oneWayRoute)
        
        let requestBody:SearchFlighRequest = SearchFlighRequest(routes: [oneWayRoute], adults: adults, childs: childs, infants: infants, cabinClass: 1, preferredCarriers: [], prohibitedCarriers: [], childrenAges: [])
        print(oneWayRoute)
        HttpUtility.shared.searchFlightService(searchFlighRequest: requestBody) { result in
            DispatchQueue.main.async {
//                isGotSearchData = "A"
                guard (result?.item1?.airSearchResponses) != nil else {
                    return
                }
                
                let airSearchResponseList: [AirSearchResponses] = (result?.item1?.airSearchResponses)!
                
                directionList = airSearchResponseList[0].directions![0]
                
                isSearching = false
                isGotSearchData = "A"
            }
        }
    }
    
    func getDateString(date:Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd"
        //2022-06-29

        // Convert Date to String
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        return dateString
    }
}

struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView()
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.5)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(3)
        }
    }
}

struct TripSegmentedView: View {
    
    @Binding var typeSelected: String
    
    let name: String
    
    private var selected: Bool {
        return typeSelected == name
    }
    
    func test() {
        
    }
    
    var body: some View {
        Button(action: {
            typeSelected = name
            print("typeSelected=\(typeSelected)")
        }, label: {
            HStack(alignment: .center, spacing: 1, content: {
                Text(name)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(self.selected ? Color("button-bg-color"): Color.white)
                
            })//: HSTACK
            .frame(width:100,height: 50)
            .background(self.selected ? Color.white.cornerRadius(5)
                        : Color("button-bg-color").cornerRadius(5))
        })//: BUTTON
    }
}

struct CabinSegmentedView: View {
    
    @Binding var cabinSelected: String
    
    let name: String
    
    private var selected: Bool {
        return cabinSelected == name
    }
    
    func test() {
        
    }
    
    var body: some View {
        Button(action: {
            cabinSelected = name
            print("typeSelected=\(cabinSelected)")
        }, label: {
            HStack(alignment: .center, spacing: 1, content: {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                
            })//: HSTACK
            .frame(width:70,height:60)
//            .frame(width:60,height: 60)
            .background(self.selected ? Color(red: 249/255, green: 228/255, blue: 209/255) : Color.white)
        })//: BUTTON
    }
}
