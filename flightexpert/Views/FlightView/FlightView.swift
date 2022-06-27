//
//  FlightView.swift
//  flightexpert
//
//  Created by sohan on 5/25/22.
//

import SwiftUI

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
    
    @StateObject var flightSearchModel = FlightSearchModel()
    
    @State var isSearching: Bool = false
    @State var isGotSearchData: String? = nil
    
    @State var directionList:[Direction] = []
    
    @State var adults: Int = 2
    @State var childs: Int = 1
    @State var infants: Int = 0
    @State var cabinClass: String = "Economy" // cabinClass
    @State var preferredCarriers: [String] = []
    @State var prohibitedCarriers: [String] = []
    @State var childrenAges: [String] = []
    @State var showAirports: Bool = false
    
    @State private var isDirectFlight = false

    @State var routeArray = [AirportData]()
    @State var routeDate = [Date]()
    
    var flightRouteTypes = ["One-Way" ,"Round-Trip", "Multi-City"]
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
    
    @State var multiCityRouteCount: Int = 1
    
    let columnSpacing: CGFloat = 5
    let rowSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.all, edges: .all)
//            BackgroundImage
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea(.all, edges: .all)
            
            NavigationLink(destination:OriginFlightList(title: "SourceToDestination",flightSearchModel: flightSearchModel), tag: "A", selection: $flightSearchModel.isGotSearchData) { EmptyView() }
            
            if !flightSearchModel.isSearching {
                VStack {
                    // TripRouteSegment
//                    ScrollView([], showsIndicators: false, content: {
//                        LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
//
//                            ForEach(flightRouteTypes, id: \.self) { type in
//                                TripSegmentedView(typeSelected: self.typeSelected, name: type){ routeType in
//
//                                    if self.typeSelected != routeType {
//                                        self.typeSelected = routeType
//                                        self.resetView()
//                                    }
//                                }
//                            }
//                        })//: GRID
//                        .frame(width: 240, height: 50)
//                        .cornerRadius(5)
//
//                    })//: SCROLL
//                    .frame(width: 300, height: 50)
//                    .background(Color("button-bg-color").cornerRadius(5))
//                    .padding(.bottom, 30)
                    
                    RadioRouteGroupBotton(selectedId: self.typeSelected) { selected in
                        print("Selected RouteType is: \(selected)")
                        self.typeSelected = selected
                        self.resetView()
                    }
                    
                    if isOneWay {
                        if routeArray.count == 2 {
                            OneWayRoute(source: $routeArray[0], destination: $routeArray[1], selectedDate: $routeDate[0])
                        }
                    }
                    if isRoundTrip {
                        if routeArray.count == 2 {
                            OneWayRoute(source: self.$routeArray[0], destination: self.$routeArray[1], selectedDate: self.$routeDate[0])
                            OneWayRoute(source: self.$routeArray[1], destination: self.$routeArray[0], selectedDate: self.$routeDate[1])
                        }
                    }
                    if isMultiCity {
                        ForEach(0 ..< multiCityRouteCount, id:\.self) { i in
                            //RouteView(route: $multiCityRoutes[i])
                            OneWayRoute(source: self.$routeArray[i], destination: self.$routeArray[i+1], selectedDate: self.$routeDate[i])
                        }
    
                        HStack {
                            Button {
                                if multiCityRouteCount < 4 {
                                    multiCityRouteCount += 1
                                    let lastOne = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
                                    self.routeArray.append(lastOne)
                                    let oneWayDate = Date()
                                    self.routeDate.append(oneWayDate)
                                }
                            } label: {
                                Label("Add More Trip", systemImage: "plus.square")
                            }
    
                            if multiCityRouteCount > 1 {
                                Button {
                                    if multiCityRouteCount > 1 {
                                        multiCityRouteCount -= 1
                                        if self.routeArray.count > 1 {
                                            self.routeArray.removeLast()
                                            self.routeDate.removeLast()
                                        }
                                    }
                                } label: {
                                    Label("Remove Trip", systemImage: "minus.square")
                                }
                            }
                        }
                    }

                    Spacer()
                    
                    VStack(spacing:0) {
                        Divider()
                            .frame(height: 1)
                            .background(Color.red)
                        HStack(alignment: .center, spacing:0) {
                            //firstDiv
                            CustomerCountView(title: "Adults", customerCount: $adults, maxNumber: 8){ count in
                                adults = count
                                if adults < infants {
                                    infants = adults
                                }
                            }
                            Divider()
                                .frame(width: 1)
                                .background(Color.red)
                            //MiddleDiv
                            CustomerCountView(title: "Childs", customerCount: $childs, maxNumber: 5){ count in
                                childs = count
                            }
                            
                            Divider()
                                .frame(width: 1)
                                .background(Color.red)
                            //LaseDiv
                            CustomerCountView(title: "Infants", customerCount: $infants, maxNumber: 8){ count in
                                infants = count
                                if infants > adults {
                                    adults = infants
                                }
                            }
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
//                        .cornerRadius(5)
                        
                    })//: SCROLL
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(height:60)
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
            else {
                LoadingView()
            }
            
        }
        .navigationTitle("Flight")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            self.resetView()
        }
        
    }
    
    func resetView() {
        routeArray = [AirportData]()
        routeDate = [Date]()
        
        if isOneWay {
            let one = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
            let two = AirportData(name: "Aalborg", city: "Aalborg", country:"Denmark", iata: "AAL")
            self.routeArray.append(contentsOf: [one,two])
            let oneWayDate = Date()
            self.routeDate.append(oneWayDate)
            
        } else if isRoundTrip {
            let one = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
            let two = AirportData(name: "Aalborg", city: "Aalborg", country:"Denmark", iata: "AAL")
            self.routeArray.append(contentsOf: [one,two])
            let oneWayDate = Date()
            let twoWayDate = Date()
            self.routeDate.append(oneWayDate)
            self.routeDate.append(twoWayDate)
            
        } else if isMultiCity {
            self.multiCityRouteCount = 1
            let one = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
            let two = AirportData(name: "Aalborg", city: "Aalborg", country:"Denmark", iata: "AAL")
            self.routeArray.append(contentsOf: [one,two])
            let oneWayDate = Date()
            self.routeDate.append(oneWayDate)
        }
    }
    
    func searchFlight() {
        var routeArrayObj = [Route]()
        
        if isOneWay {
            let oneWayRoute: Route = Route(origin: routeArray[0].iata, destination: routeArray[1].iata, departureDate: getDateString(date: routeDate[0]))
            routeArrayObj.append(oneWayRoute)
            
//            let oneWayRoute1: Route = Route(origin: "DAC", destination: "CGP", departureDate:"2022-06-16")
        } else if isRoundTrip {
            let oneWayRoute: Route = Route(origin: routeArray[0].iata, destination: routeArray[1].iata, departureDate: getDateString(date: routeDate[0]))
            let twoWayRoute: Route = Route(origin: routeArray[1].iata, destination: routeArray[0].iata, departureDate: getDateString(date: routeDate[1]))
            routeArrayObj.append(oneWayRoute)
            routeArrayObj.append(twoWayRoute)
        } else if isMultiCity {
            for n in 0..<multiCityRouteCount {
                let oneWayRoute: Route = Route(origin: routeArray[n].iata, destination: routeArray[n+1].iata, departureDate: getDateString(date: routeDate[n]))
                routeArrayObj.append(oneWayRoute)
            }
        }
        
        let requestBody:SearchFlighRequest = SearchFlighRequest(routes: routeArrayObj, adults: adults, childs: childs, infants: infants, cabinClass: 1, preferredCarriers: [], prohibitedCarriers: [], childrenAges: [])
        
        flightSearchModel.flightRouteType = flightRouteTypes[0]
        flightSearchModel.searchFlighRequest = requestBody
        flightSearchModel.getAirSearchResponses(requestBody: requestBody)
        
//        let oneWayRoute: Route = Route(origin: "DAC", destination: "CGP", departureDate:"2022-06-16")
//        let requestBody:SearchFlighRequest = SearchFlighRequest(routes: [oneWayRoute], adults: adults, childs: childs, infants: infants, cabinClass: 1, preferredCarriers: [], prohibitedCarriers: [], childrenAges: [])
//
//        //flightSearchModel.isSearching = true
//        flightSearchModel.getAirSearchResponses(requestBody: requestBody)
    }
    
    func searchFlight2() {
        isSearching = true
//        let oneWayRoute: Route = Route(origin: oneWaySource!.iata, destination: oneWayDestin!.iata, departureDate: getDateString(date: oneWayDate))
        let oneWayRoute: Route = Route(origin: "DAC", destination: "CGP", departureDate:"2022-06-16")
        
        print(oneWayRoute)
        
        let requestBody:SearchFlighRequest = SearchFlighRequest(routes: [oneWayRoute], adults: adults, childs: childs, infants: infants, cabinClass: 1, preferredCarriers: [], prohibitedCarriers: [], childrenAges: [])
        print(requestBody)
//
//        FlightAPI.searchFlight(searchFlighRequest: requestBody) { data, error in
//            guard let data = data else {return}
//            isSearching = false
//            print(data)
//
//        }
        
//        HttpUtility.shared.searchFlightService(searchFlighRequest: requestBody) { result in
//            DispatchQueue.main.async {
//                isSearching = false
//                guard (result?.item1?.airSearchResponses) != nil else {
//                    return
//                }
//
//                let airSearchResponseList: [AirSearchResponse] = (result?.item1?.airSearchResponses)!
//
//                directionList = airSearchResponseList.flatMap({ airSearchItem in
//                    return airSearchItem.directions![0]
//                })
//
////                let dirList = airSearchResponseList.map { (airSearchItem) in
////                    return airSearchItem.directions![0]
////                }
////                print(dirList)
////                directionList = dirList
//
////                directionList = airSearchResponseList[0].directions![0]
//                isGotSearchData = "A"
//            }
//        }
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



