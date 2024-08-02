//
//  FlightAPI.swift
//  flightexpert
//
//  Created by sohan on 6/2/22.
//

import Foundation

class FlightAPI {
    private static let defaultSession = URLSession(configuration: .default)
    
//    static func searchFlight(searchFlighRequest:SearchFlighRequest, completion:@escaping(SearchedFlightResponse?, String?)->Void) {
////        guard let url = URL(string: "http://localhost:83/api/Search") else {
////            return
////        }
//        var urlRequest = URLRequest(url: URL(string: "http://localhost:83/api/Search")!)
//        urlRequest.httpMethod = "post"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
//        urlRequest.httpBody = try? JSONEncoder().encode(searchFlighRequest)
//                
//        defaultSession.searchedFlightResponseTask(with:urlRequest) { data, response, error -> Void in
//            if (error == nil && data != nil) {
//                
//                guard let data = data, error != nil else {
//                    return
//                }
//                DispatchQueue.main.async {
//                    completion(data, error?.localizedDescription)
//                }
//            }
//        }.resume()
//        
//    }
}
