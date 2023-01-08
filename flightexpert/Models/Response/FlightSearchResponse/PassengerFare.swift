//
//  PassengerFare.swift
//  flightexpert
//
//  Created by sohan on 11/12/22.
//

import Foundation

struct PassengerFare : Codable {
    let discountPrice : Double?
    let ait : Double?
    let totalPrice : Double?
    let basePrice : Double?
    let equivalentBasePrice : Double?
    let taxes : Double?
    let serviceCharge : Double?
    let taxesBreakdown : [TaxesBreakdown]?

    enum CodingKeys: String, CodingKey {

        case discountPrice = "discountPrice"
        case ait = "ait"
        case totalPrice = "totalPrice"
        case basePrice = "basePrice"
        case equivalentBasePrice = "equivalentBasePrice"
        case taxes = "taxes"
        case serviceCharge = "serviceCharge"
        case taxesBreakdown = "taxesBreakdown"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        discountPrice = try values.decodeIfPresent(Double.self, forKey: .discountPrice)
        ait = try values.decodeIfPresent(Double.self, forKey: .ait)
        totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(Double.self, forKey: .basePrice)
        equivalentBasePrice = try values.decodeIfPresent(Double.self, forKey: .equivalentBasePrice)
        taxes = try values.decodeIfPresent(Double.self, forKey: .taxes)
        serviceCharge = try values.decodeIfPresent(Double.self, forKey: .serviceCharge)
        taxesBreakdown = try values.decodeIfPresent([TaxesBreakdown].self, forKey: .taxesBreakdown)
    }
}
