//
//  AirTicketingRequest.swift
//  flightexpert
//
//  Created by sohan on 6/14/22.
//


import Foundation
struct AirTicketingRequest: Codable {
    var pnr : String?
    var uniqueTransID : String?
    var status : String?
    var fromDate : String?
    var toDate : String?
    var ticketNumber : String?
}
