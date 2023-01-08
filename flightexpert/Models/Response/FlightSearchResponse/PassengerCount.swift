import Foundation
struct PassengerCount : Codable {
    let cnn : Int?
    let inf : Int?
    let adt : Int?
    let ins : Int?

    enum CodingKeys: String, CodingKey {

        case cnn = "cnn"
        case inf = "inf"
        case adt = "adt"
        case ins = "ins"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cnn = try values.decodeIfPresent(Int.self, forKey: .cnn)
        inf = try values.decodeIfPresent(Int.self, forKey: .inf)
        adt = try values.decodeIfPresent(Int.self, forKey: .adt)
        ins = try values.decodeIfPresent(Int.self, forKey: .ins)
    }
}
