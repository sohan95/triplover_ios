/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AirSearchResponses : Codable {
	let uniqueTransID : String?
	let itemCodeRef : String?
	let totalPrice : Double?
	let basePrice : Double?
	let eqivqlBasePrice : Double?
	let taxes : Double?
	let platingCarrierName : String?
	let platingCarrier : String?
	let refundable : Bool?
	let directions : [[Directions]]?
	let bookingComponents : [BookingComponents]?
	let passengerFares : PassengerFares?
	let passengerCounts : PassengerCounts?
	let bookable : Bool?

	enum CodingKeys: String, CodingKey {

		case uniqueTransID = "uniqueTransID"
		case itemCodeRef = "itemCodeRef"
		case totalPrice = "totalPrice"
		case basePrice = "basePrice"
		case eqivqlBasePrice = "eqivqlBasePrice"
		case taxes = "taxes"
		case platingCarrierName = "platingCarrierName"
		case platingCarrier = "platingCarrier"
		case refundable = "refundable"
		case directions = "directions"
		case bookingComponents = "bookingComponents"
		case passengerFares = "passengerFares"
		case passengerCounts = "passengerCounts"
		case bookable = "bookable"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uniqueTransID = try values.decodeIfPresent(String.self, forKey: .uniqueTransID)
		itemCodeRef = try values.decodeIfPresent(String.self, forKey: .itemCodeRef)
		totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice)
		basePrice = try values.decodeIfPresent(Double.self, forKey: .basePrice)
		eqivqlBasePrice = try values.decodeIfPresent(Double.self, forKey: .eqivqlBasePrice)
		taxes = try values.decodeIfPresent(Double.self, forKey: .taxes)
		platingCarrierName = try values.decodeIfPresent(String.self, forKey: .platingCarrierName)
		platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
		refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
		directions = try values.decodeIfPresent([[Directions]].self, forKey: .directions)
		bookingComponents = try values.decodeIfPresent([BookingComponents].self, forKey: .bookingComponents)
		passengerFares = try values.decodeIfPresent(PassengerFares.self, forKey: .passengerFares)
		passengerCounts = try values.decodeIfPresent(PassengerCounts.self, forKey: .passengerCounts)
		bookable = try values.decodeIfPresent(Bool.self, forKey: .bookable)
	}

}