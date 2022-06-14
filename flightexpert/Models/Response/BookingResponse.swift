//
//  BookingResponse.swift
//  flightexpert
//
//  Created by sohan on 6/11/22.
//

import Foundation
struct BookingResponse: Codable {
    var isSuccess: Bool
    var message: String?
    var uniqueTransID: String?
}

//{
//"isSuccess": true,
//"message": "Success", "uniqueTransID": "TNX6379020024"
//}
