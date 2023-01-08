import Foundation
struct BookingComponent : Codable {
	let discountPrice : Double?
	let totalPrice : Double?
	let basePrice : Double?
	let taxes : Double?
	let ait : Double?
	let fareReference : String?
	let agentAdditionalPrice : Double?
    
    enum CodingKeys: String, CodingKey {

        case discountPrice = "discountPrice"
        case totalPrice = "totalPrice"
        case basePrice = "basePrice"
        case taxes = "taxes"
        case ait = "ait"
        case fareReference = "fareReference"
        case agentAdditionalPrice = "agentAdditionalPrice"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        discountPrice = try values.decodeIfPresent(Double.self, forKey: .discountPrice)
        totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(Double.self, forKey: .basePrice)
        taxes = try values.decodeIfPresent(Double.self, forKey: .taxes)
        ait = try values.decodeIfPresent(Double.self, forKey: .ait)
        fareReference = try values.decodeIfPresent(String.self, forKey: .fareReference)
        agentAdditionalPrice = try values.decodeIfPresent(Double.self, forKey: .agentAdditionalPrice)
    }
}
