
import Foundation
struct TaxesBreakdown : Codable {
	let category : String?
	let amount : Double?
    enum CodingKeys: String, CodingKey {

        case category = "category"
        case amount = "amount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
    }
}
