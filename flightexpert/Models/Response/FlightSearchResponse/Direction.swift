import Foundation
struct Direction : Codable, Hashable  {
    let id = UUID().uuidString
    
	var from : String?
	var to : String?
	var fromAirport : String?
	var toAirport : String?
	var platingCarrierCode : String?
	var platingCarrierName : String?
	var stops : Int?
	var segments : [Segment]?
    
    var uniqueTransID : String?
    var itemCodeRef : String?
    var segmentCodeRef: String?
    var bookingComponents : [BookingComponent]?
    var totalPrice : Double?
    var departure: String?
    
    static func == (lhs: Direction, rhs: Direction) -> Bool {
        return lhs.id == rhs.id
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {

        case from = "from"
        case to = "to"
        case fromAirport = "fromAirport"
        case toAirport = "toAirport"
        case platingCarrierCode = "platingCarrierCode"
        case platingCarrierName = "platingCarrierName"
        case stops = "stops"
        case segments = "segments"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        fromAirport = try values.decodeIfPresent(String.self, forKey: .fromAirport)
        toAirport = try values.decodeIfPresent(String.self, forKey: .toAirport)
        platingCarrierCode = try values.decodeIfPresent(String.self, forKey: .platingCarrierCode)
        platingCarrierName = try values.decodeIfPresent(String.self, forKey: .platingCarrierName)
        stops = try values.decodeIfPresent(Int.self, forKey: .stops)
        segments = try values.decodeIfPresent([Segment].self, forKey: .segments)
    }
    
}
