//
//  FlightDataModel.swift
//  flightexpert
//
//  Created by sohan on 6/8/22.
//

import Foundation


class FlightSearchModel: ObservableObject {
    //@Published var prepareBookingRequest:PrepareBookingRequest = PrepareBookingRequest()
    @Published var userDataList = [UserData]()
    @Published var bookingResponse: BookingResponse?
    @Published var isBooking: Bool = false
    
    @Published var airSearchResponses: [AirSearchResponse] = []
    @Published var backwardDirections: [Direction] = []
    @Published var forwardDirections: [Direction] = []
    @Published var isSearchComplete: Bool = false
    @Published var isSearching: Bool = false
    @Published var isGotSearchData: String? = nil
    
    @Published var detailsDir: Direction? = nil
    @Published var originDir: Direction? = nil
    @Published var destinationDir: Direction? = nil
    @Published var selectedDirectionList: [[Direction]] = []
    @Published var selectedFlightList: [Direction] = []
//    @Published var selectedFlightList = Stack()
    
    //RePrice Response
    @Published var rePriceResponse: RePriceResponse = RePriceResponse()
    @Published var selection: String? = nil
    @Published var isSelectBtnTapped: Bool = false
    
    @Published var flightRouteType: String?
    
    @Published var bookedAirTicketList: [AirTicketingResponse] = []
    
    @Published var searchFlighRequest: SearchFlighRequest?
    @Published  var routeIndex: Int = 0
    
    // Filter by total Price
    @Published var maxPrice: Double = 0.0
    @Published var minPrice: Double = 0.0
    @Published var minMaxPrice: MinMaxPrice = MinMaxPrice(minPrice: 200.0, maxPrice: 10000.0)
    
    // Filter by airlines
    @Published var airlineList: [String] = []
    
    var flightRouteTypes = ["One-Way" ,"Round-Trip", "Multi-City"]
    
    var isOneWay: Bool {
        return flightRouteType == flightRouteTypes[0]
    }
    
    var isRoundTrip: Bool {
        return flightRouteType == flightRouteTypes[1]
    }
    
    var isMultiCity: Bool {
        return flightRouteType == flightRouteTypes[2]
    }
    
    func resetSearchData() {
        //self.selectedFlightList = Stack()
    }
    
    func setSelectedFlightList(direction: Direction) {
        if isOneWay {
            self.selectedFlightList.removeAll()
        } else if isRoundTrip {
            if self.routeIndex == 0 {
                self.selectedFlightList.removeAll()
                print("selectedFlightList.count=\(self.selectedFlightList.count)")
            }
        } else if isMultiCity {
            if self.routeIndex == 0 {
                self.selectedFlightList.removeAll()
                print("selectedFlightList.count=\(self.selectedFlightList.count)")
            }
        }
        self.selectedFlightList.insert(direction, at: self.routeIndex)
        print("selectedFlightList.count=\(self.selectedFlightList.count)")
    }
    
    func getSelectedFlight(index:Int) -> Direction? {
        //self.selectedFlightList.insert(direction, at: self.routeIndex)
        if index < self.selectedFlightList.count {
            return self.selectedFlightList[index]
        }
        return nil
        
    }
    
    func setOrigin(direction: Direction) {
        self.originDir = direction
        print(self.originDir!)
    }

    func setDestination(direction: Direction) {
        self.destinationDir = direction
        print(self.destinationDir!)
    }
    
    func getSelectedDirectionList(index: Int) -> [Direction]? {
        //self.selectedFlightList.insert(direction, at: self.routeIndex)
        if index < self.selectedDirectionList.count {
            return self.selectedDirectionList[index]
        }
        return nil
        
    }
    
    func getForwardDirection() {
        var directions: [Direction] = []
        self.routeIndex = 0
        self.selectedDirectionList.removeAll()
        
        //var airlineList:[String] = [] //platingCarrierName
        var airlineSet = Set<String>()
        
        for airResponse in self.airSearchResponses {
            let directionList = airResponse.directions![0].map { direction -> Direction in
                var tempDir: Direction = direction
                tempDir.uniqueTransID = airResponse.uniqueTransID
                tempDir.itemCodeRef = airResponse.itemCodeRef
                tempDir.totalPrice = airResponse.totalPrice!
                
                tempDir.platingCarrierName = airResponse.platingCarrierName
                
                tempDir.bookingComponents = airResponse.bookingComponents
                
                tempDir.segmentCodeRef = direction.segments![0].segmentCodeRef
                tempDir.departure = direction.segments![0].departure
                
                return tempDir
            }
            directions.append(contentsOf: directionList)
            
            //For All filter categories collection
            // for airline
            
            if let airline = airResponse.platingCarrierName {
                airlineSet.insert(airline)
                print("airline=\(airline)")
            }
            
        }
        
        print(directions)
        
        //airlineList
        self.airlineList = Array(airlineSet)
//        // max-min filter:
//        let directionMax = directions.max { $0.totalPrice! < $1.totalPrice! }
//        self.maxPrice = (directionMax?.totalPrice)!
//
//        let directionMin = directions.min { $0.totalPrice! < $1.totalPrice! }
//        self.minPrice = (directionMin?.totalPrice)!
        
        print("maxPrice=\(self.maxPrice)___minPrice=\(self.minPrice)")
        print("maxPrice=\(self.maxPrice)___minPrice=\(self.minPrice)")
        
        self.forwardDirections = directions
        self.selectedDirectionList.insert(directions, at: self.routeIndex)
    }
    
    func getForwardDirection2() {
        var directions: [Direction] = []
        self.routeIndex = 0
        self.selectedDirectionList.removeAll()
        
        for airResponse in self.airSearchResponses {
            let directionList = airResponse.directions![0].map { direction -> Direction in
                var tempDir: Direction = direction
                tempDir.uniqueTransID = airResponse.uniqueTransID
                tempDir.itemCodeRef = airResponse.itemCodeRef
                tempDir.totalPrice = airResponse.totalPrice!
                
                tempDir.bookingComponents = airResponse.bookingComponents
                
                tempDir.segmentCodeRef = direction.segments![0].segmentCodeRef
                tempDir.departure = direction.segments![0].departure
                return tempDir
            }
            directions.append(contentsOf: directionList)
        }
        print(directions)
        self.forwardDirections = directions
        self.selectedDirectionList.insert(directions, at: self.routeIndex)
    }
    
    func getFollowingDirection() {
        var directions: [Direction] = []
        let firstFlight = self.selectedFlightList[self.routeIndex-1]
        let itemCodeRef = firstFlight.itemCodeRef!
        let airResponseList = airSearchResponses.filter { $0.itemCodeRef!.contains(itemCodeRef) }
        if airResponseList.count > 0 {
            let airResponse = airResponseList[0]
            let directionList = airResponse.directions![self.routeIndex]
            let mappedDirectionList = directionList.map { direction -> Direction in
                var tempDir: Direction = direction
                tempDir.uniqueTransID = airResponse.uniqueTransID
                tempDir.itemCodeRef = airResponse.itemCodeRef
                
                tempDir.bookingComponents = airResponse.bookingComponents
                
                tempDir.segmentCodeRef = direction.segments![0].segmentCodeRef
                return tempDir
            }
            directions.append(contentsOf: mappedDirectionList)
        }
        
        print(directions)
//        self.selectedDirectionList[self.routeIndex] = directions
        self.selectedDirectionList.insert(directions, at: self.routeIndex)
//        print("Sohan=\(directions[0])")
    }
    // APIs Call
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
    
    func prepareBooking(requestBody:PrepareBookingRequest) {
        self.isBooking = true
        HttpUtility.shared.prepareBooking(requestBody: requestBody) { result in

            DispatchQueue.main.async { [self] in
                self.isBooking = false
                
                guard let result = result else {
                    fatalError("There must be a problem decoding the data...")
                }
                
                self.bookingResponse = result
                print(result)
            }
        }
    }
    
    
}
