import Foundation
struct FlightSearchedDataModel : Codable {
	let item1 : Item1?
	let item2 : [Item2]?
    enum CodingKeys: String, CodingKey {

        case item1 = "item1"
        case item2 = "item2"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        item1 = try values.decodeIfPresent(Item1.self, forKey: .item1)
        item2 = try values.decodeIfPresent([Item2].self, forKey: .item2)
    }
}
