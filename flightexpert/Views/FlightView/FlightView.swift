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

class FlightSearchModel: ObservableObject {
    
    @Published var airSearchResponses: [AirSearchResponse] = []
    @Published var backwardDirections:[Direction] = []
    @Published var forwardDirections:[Direction] = []
    @Published var isSearchComplete:Bool = false
    @Published var isSearching:Bool = false
    @Published var isGotSearchData: String? = nil
    
    @Published var originDir: Direction? = nil
    @Published var destinationDir: Direction? = nil
    
    func setOrigin(direction: Direction) {
        self.originDir = direction
        print(self.originDir!)
    }

    func setDestination(direction: Direction) {
        self.destinationDir = direction
        print(self.destinationDir!)
    }
    
    func getAirSearchResponses(requestBody:SearchFlighRequest) {
        self.isSearching = true
        HttpUtility.shared.searchFlightService(searchFlighRequest: requestBody) { result in
            
            DispatchQueue.main.async { [ self] in
                self.isSearchComplete = true
                self.isSearching = false
                guard (result?.item1?.airSearchResponses) != nil else {
                    return
                }

                self.airSearchResponses = (result?.item1?.airSearchResponses)!
                
                if self.airSearchResponses.count > 0 {
                    self.isGotSearchData = "A"
                }
                
//                let forwardD = self.airSearchResponses.flatMap({ airSearchItem in
//                    return airSearchItem.directions![0]
//                })
//
//                let backwardD = self.airSearchResponses.flatMap({ airSearchItem in
//                    return airSearchItem.directions![1]
//                })
//
//                self.forwardDirections = forwardD
//                self.backwardDirections = backwardD
            }
        }
    }
    
    func getForwardDirection() {
        
        let forwardD = self.airSearchResponses.flatMap({ airSearchItem in
            return airSearchItem.directions![0]
        })
        
        self.forwardDirections = forwardD
    }
    
    func backwardDirection() {
        
        let backwardD = self.airSearchResponses.flatMap({ airSearchItem in
            return airSearchItem.directions![1]
        })
        
        self.backwardDirections = backwardD
    }
    
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
            
            NavigationLink(destination:OriginFlightList(title: "SourceToDestination",flightSearchModel: flightSearchModel), tag: "A", selection: $flightSearchModel.isGotSearchData) { EmptyView() }
            if !flightSearchModel.isSearching {
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
            else {
                LoadingView()
            }
            
        }
        .navigationTitle("Flight")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func searchFlight() {
        let oneWayRoute: Route = Route(origin: "DAC", destination: "CGP", departureDate:"2022-06-10")
        let requestBody:SearchFlighRequest = SearchFlighRequest(routes: [oneWayRoute], adults: adults, childs: childs, infants: infants, cabinClass: 1, preferredCarriers: [], prohibitedCarriers: [], childrenAges: [])
        
        //flightSearchModel.isSearching = true
        flightSearchModel.getAirSearchResponses(requestBody: requestBody)
    }
    
    func searchFlight2() {
        isSearching = true
//        let oneWayRoute: Route = Route(origin: oneWaySource!.iata, destination: oneWayDestin!.iata, departureDate: getDateString(date: oneWayDate))
        let oneWayRoute: Route = Route(origin: "DAC", destination: "CGP", departureDate:"2022-06-10")
        
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
        HttpUtility.shared.searchFlightService(searchFlighRequest: requestBody) { result in
            DispatchQueue.main.async {
                isSearching = false
                guard (result?.item1?.airSearchResponses) != nil else {
                    return
                }

                let airSearchResponseList: [AirSearchResponse] = (result?.item1?.airSearchResponses)!

                directionList = airSearchResponseList.flatMap({ airSearchItem in
                    return airSearchItem.directions![0]
                })
                
//                let dirList = airSearchResponseList.map { (airSearchItem) in
//                    return airSearchItem.directions![0]
//                }
//                print(dirList)
//                directionList = dirList
                
//                directionList = airSearchResponseList[0].directions![0]
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
    
    var body: some View {
        Button(action: {
            typeSelected = name
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
