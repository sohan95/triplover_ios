//
//  AirTicketingResponse.swift
//  flightexpert
//
//  Created by sohan on 6/14/22.
//

import Foundation

struct AirTicketingResponse: Codable, Hashable {
    //var id = UUID().uuidString
    var paxName : String?
    var issueDate : String?
    var travellDate : String?
    var uniqueTransID : String?
    var pnr : String?
    var ticketNumber : String?
    var status : String?
    var platingCarrier: String?
    var airlineName: String?
    var origin: String?
    var destination: String?
    var journeyType: String?
    var gatewayCharge: Double
    
    static func == (lhs: AirTicketingResponse, rhs: AirTicketingResponse) -> Bool {
            return lhs.uniqueTransID == rhs.uniqueTransID
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueTransID)
    }
}
