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
    
//    @StateObject var flightSearchModel = FlightSearchModel()
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    @State private var sheetMode: SheetMode = .half
    @State var isSearching: Bool = false
    @State var isGotSearchData: String? = nil
    @State private var showOptionModal = false
    
    @State var directionList:[Direction] = []
    
    @State var adults: Int = 1
    @State var childs: Int = 0
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
//    @State var selectedModel: RandomModel? = nil
    @State var bgHeight: Double = 420.0
    @State var shouldScroll: Bool = false
    
    
    let columnSpacing: CGFloat = 5
    let rowSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
    }
    
    @Environment(\.presentationMode) var presentationMode
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image(systemName: "arrow.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            BackgroundImage
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all, edges: .all)
            
            NavigationLink(destination:OriginFlightList(title: "SourceToDestination"), tag: "A", selection: $flightSearchModel.isGotSearchData) { EmptyView() }
           
            if !flightSearchModel.isSearching {
                VStack() {
                    ScrollView(axes, showsIndicators: false) {
                        VStack(spacing:15) {
                            VStack(spacing: 10) {
                                Text("Flights")
                                    .font(.system(size: 24, weight: .bold))
                                RadioRouteGroupBotton(selectedId: $typeSelected) { selected in
                                    print("Selected RouteType is: \(selected)")
                                    self.typeSelected = selected
                                    self.resetView()
                                }
                                .padding(.horizontal,10)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.top,20)
                            
                            VStack {
                                VStack(spacing:10){
                                    if !isMultiCity {
                                        if routeArray.count == 2 {
                                            //Row-1
                                            ZStack {
                                                HStack(spacing: 10) {
                                                    RoutePointButton(source: $routeArray[0])
                                                    RoutePointButton(source: $routeArray[1])
                                                }
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 15)
                                                
                                                if isRoundTrip {
                                                    Image("repeat1")
                                                        .resizable()
                                                        .frame(width: 25, height: 25, alignment: .center)
                                                        .foregroundColor(.white)
                                                        .padding(10)
                                                        .background(.gray)
                                                        .opacity(0.3)
                                                        .clipShape(Circle())
                                                    
                                                }
                                            }
                                            //Row-2
                                            HStack(spacing: 10) {
                                                ZStack {
                                                    VStack(alignment:.leading, spacing: 5){
                                                        Text("JOURNEY DATE")
                                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                                        Text("\(routeDate[0].formatted(date: .long, time: .omitted))")
                                                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                                                            .foregroundColor(.black)
                                                        Text("Friday")
                                                            .font(.system(size: 12, weight: .medium, design: .rounded))
                                                    }
                                                    DatePicker("", selection: $routeDate[0], in: Date()..., displayedComponents: .date)
                                                        .labelsHidden()
                                                        .accentColor(.red)
                                                        .background(.white)
                                                        .opacity(0.05)
                                                }
                                                .frame(minWidth:0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                                .background(.white)
                                                .addBorder(Color.gray, width: 2, cornerRadius: 10)
                                                
                                                ZStack{
                                                    VStack(alignment:.leading, spacing: 5) {
                                                        Text("RETURN DATE")
                                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                                        if isRoundTrip {
                                                            Text("\(routeDate[1].formatted(date: .long, time: .omitted))")
                                                                .font(.system(size: 16, weight: .heavy, design: .rounded))
                                                                .foregroundColor(.black)
                                                            Text("Friday")
                                                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                                        } else {
                                                            Button {
                                                                self.typeSelected = flightRouteTypes[1]
                                                                self.resetView()
                                                            } label: {
                                                                Text("Save more on return")
                                                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                                            }
                                                        }
                                                    }
                                                    if isRoundTrip {
                                                        DatePicker("", selection: $routeDate[1], in: Date()..., displayedComponents: .date)
                                                            .labelsHidden()
                                                            .accentColor(.red)
                                                            .background(.white)
                                                            .opacity(0.05)
                                                    }
                                                }
                                                .frame(minWidth:0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                                .background(.white)
                                                .addBorder(Color.gray, width: 2, cornerRadius: 10)
                                            }
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 15)
                                        }
                                    }
                                    else {
                                        HStack {
                                            Spacer()
                                            Button {
                                                print("Edit button was tapped")
                                                if multiCityRouteCount < 4 {
                                                   multiCityRouteCount += 1
                                                    self.bgHeight = bgHeight + Double(self.multiCityRouteCount) * 40.0
                                                   let lastOne = AirportData(name: "Aasiaat", city: "Aasiaat", country:"Greenland", iata: "JEG")
                                                   self.routeArray.append(lastOne)
                                                   let oneWayDate = Date()
                                                   self.routeDate.append(oneWayDate)
                                               }
                                            } label: {
                                                Label("Add More City", systemImage: "plus")
                                            }
                                            .font(.system(size: 12, weight: .bold, design: .rounded))
                                            .buttonStyle(.bordered)
                                            .foregroundColor(.black)
                                        }
                                        .padding(10)
                                        
                                        ForEach(0 ..< multiCityRouteCount, id:\.self) { i in
                                            VStack {
                                                HStack(spacing: 10) {
                                                    RoutePointButton(source: $routeArray[i])
                                                    RoutePointButton(source: $routeArray[i+1])
                                                }
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 15)
                                                
                                                HStack {
                                                    if i > 1 {
                                                    Button("Remove") {
                                                        routePathUpdate(isIncrease: true)
                                                    }
                                                    .foregroundColor(Color.red)
                                                    }
                                                    DatePicker("Departure Time", selection: $routeDate[i], in: Date()..., displayedComponents: .date)
                                                        .padding(.leading, 50)
                                                        .padding(.trailing, 20)
                                                        .padding(.top,1)
                                                        .accentColor(.red)
                                                        .background(.white)
                                                        .foregroundColor(Color.black)
                                                }
                                                .padding(.horizontal, 10)
                                                
                                            }
                                        }
    
                                    }
                                    //Row-Last Row for Cabin, passenger and Go Btn
                                    HStack(spacing: 5) {
                                        //SearchFilterButton()
                                        Button {
                                            showOptionModal = true
                                        } label: {
                                            VStack(alignment:.leading, spacing: 5){
                                                Text("TRAVEL, CLASS")
                                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                                Text("\(adults+childs+infants) Traveler")
                                                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                                                Text(cabinClass)
                                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                            }
                                            .padding(5)
                                        }
                                        .frame(minWidth:0, maxWidth: .infinity,minHeight: 80, maxHeight: 80)
                                        .background(.white)
                                        .addBorder(Color.gray, width: 2, cornerRadius: 10)
                                        
                                        Button {
                                            self.searchFlight()
                                        } label: {
                                            Text("GO!")
                                            .font(.system(size: 24, weight:.heavy))
                                            .foregroundColor(.white)
                                        }
                                        .frame(minWidth:0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                        .background(RoundedRectangle(cornerRadius: 15)
                                            .fill(blueGradient))
                                    }
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 15)
                                }
                            }
                        }
                        .frame(height: bgHeight)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                            .padding([.leading, .trailing], 10)
                        )
                        
                        Image("image_2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(10)
                        
                    }
                    .offset(y: 50)
                    .clipped()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack)
                .onAppear() {
                    self.resetView()
                }
                
                SearchOptionModal(isShowing:$showOptionModal,
                                  adults: $adults,
                                  childs: $childs,
                                  infants: $infants,
                                  cabinClass: $cabinClass,
                                  doneAction:self.changeClassAndTraveler)
            }
            else {
                LoadingView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .environmentObject(flightSearchModel)
    }
    
    private var axes: Axis.Set {
        return shouldScroll ? .vertical : []
    }
        
    func routePathUpdate(isIncrease: Bool) {
        if multiCityRouteCount > 2 {
            multiCityRouteCount -= 1
            self.bgHeight = bgHeight - Double(self.multiCityRouteCount) * 40.0
            if self.routeArray.count > 1 {
                self.routeArray.removeLast()
                self.routeDate.removeLast()
            }
            
        }
    }
    
    func resetView() {
        routeArray = [AirportData]()
        routeDate = [Date]()
        bgHeight = 420.0
        shouldScroll = false
        
        if isOneWay {
            let one = AirportData(name: "Hazrat Shahjalal International Airport", city: "Dhaka", country:"Bangladesh", iata: "DAC")
            let two = AirportData(name: "Shah Amanat Intl", city: "Chittagong", country:"Bangladesh", iata: "CGP")
            self.routeArray.append(contentsOf: [one,two])
            
            let oneWayDate = Date()
            self.routeDate.append(oneWayDate)
            
        } else if isRoundTrip {
            
            routeArray = [AirportData]()
            let one = AirportData(name: "Hazrat Shahjalal International Airport", city: "Dhaka", country:"Bangladesh", iata: "DAC")
            let two = AirportData(name: "Shah Amanat Intl", city: "Chittagong", country:"Bangladesh", iata: "CGP")
            self.routeArray.append(contentsOf: [one,two])
        
            let oneWayDate = Date()
            let twoWayDate = Date()
            self.routeDate.append(contentsOf: [oneWayDate,twoWayDate])
            
        } else if isMultiCity {
            shouldScroll = true
            self.multiCityRouteCount = 2
            self.bgHeight = self.bgHeight + Double(self.multiCityRouteCount) * 40.0
            let one = AirportData(name: "Hazrat Shahjalal International Airport", city: "Dhaka", country:"Bangladesh", iata: "DAC")
            let two = AirportData(name: "Shah Amanat Intl", city: "Chittagong", country:"Bangladesh", iata: "CGP")
            
            let three = AirportData(name: "Osmany Intl", city: "Sylhet Osmani", country:"Bangladesh", iata: "ZYL")
            
            self.routeArray.append(contentsOf: [one,two,three])
            let oneWayDate = Date()
            let twoWayDate = Date()
            self.routeDate.append(contentsOf: [oneWayDate,twoWayDate])
        }
    }
    
    func searchFlight() {
        var routeArrayObj = [Route]()
        
        if isOneWay {
            flightSearchModel.flightRouteType = flightRouteTypes[0]
            let oneWayRoute: Route = Route(origin: routeArray[0].iata, destination: routeArray[1].iata, departureDate: getDateString(date: routeDate[0]))
            routeArrayObj.append(oneWayRoute)
            
//            let oneWayRoute1: Route = Route(origin: "DAC", destination: "CGP", departureDate:"2022-06-16")
        } else if isRoundTrip {
            flightSearchModel.flightRouteType = flightRouteTypes[1]
            let oneWayRoute: Route = Route(origin: routeArray[0].iata, destination: routeArray[1].iata, departureDate: getDateString(date: routeDate[0]))
            let twoWayRoute: Route = Route(origin: routeArray[1].iata, destination: routeArray[0].iata, departureDate: getDateString(date: routeDate[1]))
            routeArrayObj.append(oneWayRoute)
            routeArrayObj.append(twoWayRoute)
        } else if isMultiCity {
            flightSearchModel.flightRouteType = flightRouteTypes[2]
            for n in 0..<multiCityRouteCount {
                let oneWayRoute: Route = Route(origin: routeArray[n].iata, destination: routeArray[n+1].iata, departureDate: getDateString(date: routeDate[n]))
                routeArrayObj.append(oneWayRoute)
            }
        }
        
        let requestBody:SearchFlighRequest = SearchFlighRequest(routes: routeArrayObj, adults: adults, childs: childs, infants: infants, cabinClass: 1, preferredCarriers: [], prohibitedCarriers: [], childrenAges: [])
        
        //Save SearchType and others
        
        flightSearchModel.searchFlighRequest = requestBody
        
        flightSearchModel.getAirSearchResponses(requestBody: requestBody)
        
//        let oneWayRoute: Route = Route(origin: "DAC", destination: "CGP", departureDate:"2022-06-16")
//        let requestBody:SearchFlighRequest = SearchFlighRequest(routes: [oneWayRoute], adults: adults, childs: childs, infants: infants, cabinClass: 1, preferredCarriers: [], prohibitedCarriers: [], childrenAges: [])
//
//        //flightSearchModel.isSearching = true
//        flightSearchModel.getAirSearchResponses(requestBody: requestBody)
    }
    
    func searchFlightNotUsed() {
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
    
    func changeClassAndTraveler() {
            print("do something")
    }
}

struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView()
    }
}

extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
 }
