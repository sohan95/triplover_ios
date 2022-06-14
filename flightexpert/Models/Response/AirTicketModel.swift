//
//  AirTicketingResponse.swift
//  flightexpert
//
//  Created by sohan on 6/14/22.
//

import Foundation

struct AirTicketModel: Codable {
    var paxName : String?
    var issueDate : String?
    var travellDate : String?
    var uniqueTransID : String?
    var pnr : String?
    var ticketNumber : String?
    var status : String?
}
