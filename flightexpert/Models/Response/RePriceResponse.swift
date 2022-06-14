//
//  RePriceResponse.swift
//  flightexpert
//
//  Created by sohan on 6/13/22.
//

import Foundation

struct RePriceResponse : Codable {
    
    struct Item1 : Codable {
        struct Direction : Codable {
            struct Segment : Codable {
                struct Details : Codable {
                    var origin : String?
                    var originName : String?
                    var originTerminal : String?
                    var destination : String?
                    var destinationName : String?
                    var destinationTerminal : String?
                    var departure : String?
                    var arrival : String?
                    var flightTime : String?
                    var travelTime : String?
                    var equipment : String?
                }
                var from : String?
                var fromAirport : String?
                var to : String?
                var toAirport : String?
                var group : Int
                var departure : String?
                var arrival : String?
                var airline : String?
                var flightNumber : String?
                var segmentCodeRef : String?
                var details : [Details]?
                var serviceClass : String?
                var plane : [String]?
                var duration : [String]?
                var techStops : [Int]
                var bookingClass : String?
                var bookingCount : String?
                var baggage : [String]?
                var fareBasisCode : String?
                var airlineCode : String?
            }
            var from : String?
            var to : String?
            var fromAirport : String?
            var toAirport : String?
            var platingCarrierCode : String?
            var platingCarrierName : String?
            var stops : Int
            var segments : [Segment]?
        }
        struct BookingComponent : Codable {
            var discountPrice : Double
            var totalPrice : Double
            var basePrice : Double
            var taxes : Double
            var ait : Double
            var fareReference : String?
            var agentAdditionalPrice : Double
        }
        
        struct PassengerFares : Codable {
            struct FareDetails : Codable {
                struct TaxesBreakdown : Codable {
                    var category : String?
                    var amount : Double
                }
                
                var discountPrice : Double
                var ait : Double
                var totalPrice : Double
                var basePrice : Double
                var equivalentBasePrice : Double
                var taxes : Double
                var serviceCharge : Double
                var taxesBreakdown : [TaxesBreakdown]?
            }
            
            var adt : FareDetails?
            var cnn : FareDetails?
            var inf : FareDetails?
            var ins : FareDetails?
        }
        struct PassengerCounts : Codable {
            var cnn : Int
            var inf : Int
            var adt : Int
            var ins : Int
        }
        var isPriceChanged : Bool
        var priceCodeRef : String?
        var uniqueTransID : String?
        var itemCodeRef : String?
        var totalPrice : Double
        var basePrice : Double
        var eqivqlBasePrice : Double
        var taxes : Double
        var platingCarrierName : String?
        var platingCarrier : String?
        var refundable : Bool
        var directions : [[Direction]]?
        var bookingComponents : [BookingComponent]?
        var passengerFares : PassengerFares?
        var passengerCounts : PassengerCounts?
        var bookable : Bool
    }
    
    struct Item2 : Codable {
        var apiRef : Int
        var uniqueTransID : String?
        var isSuccess : Bool
        var requestTime : String?
        var responseTime : String?
        var conversionTime : String?
        var timeTicks : Int
        var message : String?
    }
    
    var item1 : Item1?
    var item2 : Item2?
}
