

import Foundation
struct PassengerInfoes : Encodable {
	var nameElement : NameElement?
	var contactInfo : ContactInfo?
	var documentInfo : DocumentInfo?
	var passengerType : String?
	var gender : String?
	var dateOfBirth : String?
	var passengerKey : String?
	var isLeadPassenger : Bool?
	var meal : String?

//	enum CodingKeys: String, CodingKey {
//
//		case nameElement = "nameElement"
//		case contactInfo = "contactInfo"
//		case documentInfo = "documentInfo"
//		case passengerType = "passengerType"
//		case gender = "gender"
//		case dateOfBirth = "dateOfBirth"
//		case passengerKey = "passengerKey"
//		case isLeadPassenger = "isLeadPassenger"
//		case meal = "meal"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		nameElement = try values.decodeIfPresent(NameElement.self, forKey: .nameElement)
//		contactInfo = try values.decodeIfPresent(ContactInfo.self, forKey: .contactInfo)
//		documentInfo = try values.decodeIfPresent(DocumentInfo.self, forKey: .documentInfo)
//		passengerType = try values.decodeIfPresent(String.self, forKey: .passengerType)
//		gender = try values.decodeIfPresent(String.self, forKey: .gender)
//		dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
//		passengerKey = try values.decodeIfPresent(String.self, forKey: .passengerKey)
//		isLeadPassenger = try values.decodeIfPresent(Bool.self, forKey: .isLeadPassenger)
//		meal = try values.decodeIfPresent(String.self, forKey: .meal)
//	}

}
