//
//  PassengerFare.swift
//  flightexpert
//
//  Created by sohan on 11/12/22.
//

import Foundation

struct PassengerFare : Codable {
    var discountPrice : Double
    var ait : Double
    var totalPrice : Double
    var basePrice : Double
    var equivalentBasePrice : Double
    var taxes : Double
    var serviceCharge : Double
    var taxesBreakdown : [TaxesBreakdown]?
}
