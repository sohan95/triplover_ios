/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct BookingConfirmResponse : Codable {

    struct Item1 : Codable {
        struct TicketInfo : Codable {
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
        }
        struct FlightInfo : Codable {
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
            struct PassengerCounts : Codable {
                var cnn : Int
                var inf : Int
                var adt : Int
                var ins : Int
            }
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
                    struct Baggage : Codable {
                        var units : String?
                        var amount : Double
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
            }
            var directions : [[Direction]]?
            var bookingComponents : [BookingComponent]?
            var passengerFares : PassengerFares?
            var passengerCounts : PassengerCounts?
        }
        
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
    struct Data : Codable {
        var item1 : Item1?
        var item2 : Item2?
    }
	var isSuccess : Bool
	var message : String?
	var data : Data?

}
