

import Foundation
struct DocumentInfo : Encodable {
	var documentType : String
	var documentNumber : String
	var expireDate : String
	var frequentFlyerNumber : String
	var issuingCountry : String
	var nationality : String

//	enum CodingKeys: String, CodingKey {
//
//		case documentType = "documentType"
//		case documentNumber = "documentNumber"
//		case expireDate = "expireDate"
//		case frequentFlyerNumber = "frequentFlyerNumber"
//		case issuingCountry = "issuingCountry"
//		case nationality = "nationality"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		documentType = try values.decodeIfPresent(String.self, forKey: .documentType)
//		documentNumber = try values.decodeIfPresent(String.self, forKey: .documentNumber)
//		expireDate = try values.decodeIfPresent(String.self, forKey: .expireDate)
//		frequentFlyerNumber = try values.decodeIfPresent(String.self, forKey: .frequentFlyerNumber)
//		issuingCountry = try values.decodeIfPresent(String.self, forKey: .issuingCountry)
//		nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
//	}

}
