

import Foundation
struct NameElement : Encodable {
	var title : String
	var firstName : String
	var lastName : String
	var middleName : String

//	enum CodingKeys: String, CodingKey {
//
//		case title = "title"
//		case firstName = "firstName"
//		case lastName = "lastName"
//		case middleName = "middleName"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		title = try values.decodeIfPresent(String.self, forKey: .title)
//		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
//		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
//		middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
//	}

}
