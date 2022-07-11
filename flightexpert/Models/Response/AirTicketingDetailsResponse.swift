//
//  AirTicketingDetailsResponse.swift
//  flightexpert
//
//  Created by sohan on 7/9/22.
//

import Foundation

struct AirTicketingDetailsResponse : Codable {
    
    struct TicketInfo : Codable, Hashable {
        
        struct PassengerInfo : Codable {
            struct NameElement : Codable {
                var title : String?
                var firstName : String?
                var lastName : String?
                var middleName : String?
            }
            
            struct ContactInfo : Codable {
                var email : String?
                var phone : String?
                var phoneCountryCode : String?
                var countryCode : String?
                var cityName : String?
            }
            
            struct DocumentInfo : Codable {
                var documentType : String?
                var documentNumber : String?
                var expireDate : String?
                var frequentFlyerNumber : String?
                var issuingCountry : String?
                var nationality : String?
            }
            
            var nameElement : NameElement?
            var contactInfo : ContactInfo?
            var documentInfo : DocumentInfo?
            var passengerType : String?
            var gender : String?
            var dateOfBirth : String?
            var passengerKey : String?
        }
        
        var passengerInfo : PassengerInfo?
        var ticketNumbers : [String]?
        
        var id:String? = UUID().uuidString
        static func == (lhs: TicketInfo, rhs: TicketInfo) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

    }
    struct FlightInfo : Codable {
        struct Direction : Codable, Hashable {
            struct Segment : Codable {
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
                var techStops : [String]?
                var bookingClass : String?
                var bookingCount : String?
                var baggage : [Baggage]?
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
            
            var id: String? = UUID().uuidString
            static func == (lhs: Direction, rhs: Direction) -> Bool {
                return lhs.id == rhs.id
                }

            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }
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
        struct PassengerCounts : Codable {
            var cnn : Int
            var inf : Int
            var adt : Int
            var ins : Int
        }
        
        struct PassengerFares : Codable {
            struct PassengerFare : Codable {
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
            var adt : PassengerFare?
            var cnn : PassengerFare?
            var inf : PassengerFare?
            var ins : PassengerFare?
        }
        
        var directions : [[Direction]]?
        var bookingComponents : [BookingComponent]?
        var passengerFares : PassengerFares?
        var passengerCounts : PassengerCounts?
    }
    
    var flightType : String?
    var journeyType : String?
    var issueDate : String?
    var gatewayCharge : Double
    var warnings : [String]?
    var ticketInfoes : [TicketInfo]?
    var flightInfo : FlightInfo?
    var pnr : String?
    var status : String?
    var remarks : String?
    var itemCodeRef : String?
    var priceCodeRef : String?
    var bookingCodeRef : String?
    var ticketCodeRef : String?
    var uniqueTransID : String?

}
