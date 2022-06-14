

import Foundation
struct ContactInfo : Encodable {
	var email : String
	var phone : String
	var phoneCountryCode : String
	var countryCode : String
	var cityName : String

//	enum CodingKeys: String, CodingKey {
//
//		case email = "email"
//		case phone = "phone"
//		case phoneCountryCode = "phoneCountryCode"
//		case countryCode = "countryCode"
//		case cityName = "cityName"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		email = try values.decodeIfPresent(String.self, forKey: .email)
//		phone = try values.decodeIfPresent(String.self, forKey: .phone)
//		phoneCountryCode = try values.decodeIfPresent(String.self, forKey: .phoneCountryCode)
//		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
//		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
//	}

}
