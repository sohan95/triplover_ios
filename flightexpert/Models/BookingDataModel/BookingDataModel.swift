
import Foundation
struct BookingDataModel {
	var passengerInfoes : [PassengerInfoes]
	var taxRedemptions : [String]
	var priceCodeRef : String
	var uniqueTransID : String
	var itemCodeRef : String

//	enum CodingKeys: String, CodingKey {
//
//		case passengerInfoes = "passengerInfoes"
//		case taxRedemptions = "taxRedemptions"
//		case priceCodeRef = "priceCodeRef"
//		case uniqueTransID = "uniqueTransID"
//		case itemCodeRef = "itemCodeRef"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		passengerInfoes = try values.decodeIfPresent([PassengerInfoes].self, forKey: .passengerInfoes)
//		taxRedemptions = try values.decodeIfPresent([String].self, forKey: .taxRedemptions)
//		priceCodeRef = try values.decodeIfPresent(String.self, forKey: .priceCodeRef)
//		uniqueTransID = try values.decodeIfPresent(String.self, forKey: .uniqueTransID)
//		itemCodeRef = try values.decodeIfPresent(String.self, forKey: .itemCodeRef)
//	}

}
