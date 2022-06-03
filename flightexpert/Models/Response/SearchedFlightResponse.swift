//
//  SearchedFlightResponse.swift
//  flightexpert
//
//  Created by sohan on 6/2/22.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchedFlightResponse = try? newJSONDecoder().decode(SearchedFlightResponse.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.searchedFlightResponseTask(with: url) { searchedFlightResponse, response, error in
//     if let searchedFlightResponse = searchedFlightResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - SearchedFlightResponse
struct SearchedFlightResponse: Codable {
    let item1: Item1
    let item2: [Item2]
}

// MARK: - Item1
struct Item1: Codable {
    let airSearchResponses: [AirSearchResponse]
    let airlineFilters: [AirlineFilter]
    let minMaxPrice: MinMaxPrice
    let stops: [Int]
    let totalFlights: Int
}

// MARK: - AirSearchResponse
struct AirSearchResponse: Codable {
    let uniqueTransID, itemCodeRef: String
    let totalPrice, basePrice, eqivqlBasePrice, taxes: Int
    let platingCarrierName, platingCarrier: String
    let refundable: Bool
    let directions: [[Direction]]
    let bookingComponents: [BookingComponent]
    let passengerFares: PassengerFares
    let passengerCounts: PassengerCounts
    let bookable: Bool
}

// MARK: - BookingComponent
struct BookingComponent: Codable {
    let discountPrice, totalPrice, basePrice, taxes: Int
    let ait: Int
    let fareReference: String
    let agentAdditionalPrice: Int
}

// MARK: - Direction
struct Direction: Codable {
    let from, to, fromAirport, toAirport: String
    let platingCarrierCode, platingCarrierName: String
    let stops: Int
    let segments: [Segment]
}

// MARK: - Segment
struct Segment: Codable {
    let from, fromAirport, to, toAirport: String
    let group: Int
    let departure, arrival, airline, flightNumber: String
    let segmentCodeRef: String
    let details: [Detail]
    let serviceClass: String
    let plane, duration: [String]
    let techStops: [Int]
    let bookingClass, bookingCount: String
    let baggage: [Baggage]
    let fareBasisCode, airlineCode: String
}

// MARK: - Baggage
struct Baggage: Codable {
    let units: String
    let amount: Int
}

// MARK: - Detail
struct Detail: Codable {
    let origin, originName, originTerminal, destination: String
    let destinationName: String
    let departure, arrival, flightTime, travelTime: String
    let equipment: String
}


// MARK: - PassengerCounts
struct PassengerCounts: Codable {
    let cnn, inf, adt, ins: Int
}

// MARK: - PassengerFares
struct PassengerFares: Codable {
    let adt, cnn: ADT
}

// MARK: - ADT
struct ADT: Codable {
    let discountPrice, ait, totalPrice, basePrice: Int
    let equivalentBasePrice, taxes, serviceCharge: Int
    let taxesBreakdown: [TaxesBreakdown]
}


// MARK: - TaxesBreakdown
struct TaxesBreakdown: Codable {
    let category: String
    let amount: Int
}


// MARK: - AirlineFilter
struct AirlineFilter: Codable {
    let airlineCode, airlineName: String
    let totalFlights, minPrice: Int
}

// MARK: - MinMaxPrice
struct MinMaxPrice: Codable {
    let minPrice, maxPrice: Int
}

// MARK: - Item2
struct Item2: Codable {
    let apiRef: Int
    let uniqueTransID: String
    let isSuccess: Bool
    let requestTime, responseTime, conversionTime: String
    let timeTicks: Double
}

// MARK: - Helper functions for creating encoders and decoders

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}

// MARK: - URLSession response handlers

//extension URLSession {
//    fileprivate func codableTask<T: Codable>(request: URLRequest, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//
//        return self.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                completionHandler(nil, response, error)
//                return
//            }
//            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
//        }
//    }
//
//    func searchedFlightResponseTask(with urlRequest: URLRequest, completionHandler: @escaping (SearchedFlightResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(request: urlRequest, completionHandler: completionHandler)
//    }
//}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
