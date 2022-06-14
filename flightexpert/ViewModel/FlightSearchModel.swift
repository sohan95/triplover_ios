//
//  FlightDataModel.swift
//  flightexpert
//
//  Created by sohan on 6/8/22.
//

import Foundation

class FlightSearchModel: ObservableObject {
    
    @Published var airSearchResponses: [AirSearchResponse] = []
    @Published var backwardDirections: [Direction] = []
    @Published var forwardDirections: [Direction] = []
    @Published var isSearchComplete: Bool = false
    @Published var isSearching: Bool = false
    @Published var isGotSearchData: String? = nil
    
    @Published var originDir: Direction? = nil
    @Published var destinationDir: Direction? = nil
    
    //RePrice Response
    @Published var rePriceResponse: RePriceResponse = RePriceResponse()
    @Published var selection: String? = nil
    
    
    
    func setOrigin(direction: Direction) {
        self.originDir = direction
        print(self.originDir!)
    }

    func setDestination(direction: Direction) {
        self.destinationDir = direction
        print(self.destinationDir!)
    }
    
    
    func getForwardDirection() {
        
        
        
//        self.airSearchResponses = self.airSearchResponses.map { airResponse -> AirSearchResponse in
//
////            var directions: [Direction] = airResponse.directions![0];
//
//            var abcd = airResponse.directions![0].map { direction -> Direction in
//                var tempDir: Direction = direction
//                tempDir.uniqueTransID = airResponse.uniqueTransID
//                tempDir.itemCodeRef = airResponse.itemCodeRef
//                return tempDir
//            }
//
//            return airResponse
//
//        }
        var directions: [Direction] = []
        
        for airResponse in self.airSearchResponses {
            let directionList = airResponse.directions![0].map { direction -> Direction in
                var tempDir: Direction = direction
                tempDir.uniqueTransID = airResponse.uniqueTransID
                tempDir.itemCodeRef = airResponse.itemCodeRef
                tempDir.segmentCodeRef = direction.segments![0].segmentCodeRef
                return tempDir
            }
            directions.append(contentsOf: directionList)
        }
        
        print(directions)
        
//        let forwardD = self.airSearchResponses.flatMap({ airSearchItem in
//            return airSearchItem.directions![0]
//        })
        
        self.forwardDirections = directions
    }
    
    func backwardDirection() {
        
        let backwardD = self.airSearchResponses.flatMap({ airSearchItem in
            return airSearchItem.directions![1]
        })
        
        self.backwardDirections = backwardD
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
    func rePriceStatus(requestBody: RePriceRequest) {
        self.isSearching = true
        HttpUtility.shared.rePriceService(rePriceRequest: requestBody) { result in
            
            DispatchQueue.main.async { [ self] in
                self.isSearchComplete = true
                self.isSearching = false
                guard (result) != nil else {
                    return
                }
                self.rePriceResponse = result!
                self.selection = "TravelerDetails"
            }
        }
    }
    
}
