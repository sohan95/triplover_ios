import Foundation
struct Details : Codable {
	let origin : String?
	let originName : String?
	let originTerminal : String?
	let destination : String?
	let destinationName : String?
	let destinationTerminal : String?
	let departure : String?
	let arrival : String?
	let flightTime : String?
	let travelTime : String?
	let equipment : String?
    
    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case originName = "originName"
        case originTerminal = "originTerminal"
        case destination = "destination"
        case destinationName = "destinationName"
        case destinationTerminal = "destinationTerminal"
        case departure = "departure"
        case arrival = "arrival"
        case flightTime = "flightTime"
        case travelTime = "travelTime"
        case equipment = "equipment"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        originName = try values.decodeIfPresent(String.self, forKey: .originName)
        originTerminal = try values.decodeIfPresent(String.self, forKey: .originTerminal)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        destinationName = try values.decodeIfPresent(String.self, forKey: .destinationName)
        destinationTerminal = try values.decodeIfPresent(String.self, forKey: .destinationTerminal)
        departure = try values.decodeIfPresent(String.self, forKey: .departure)
        arrival = try values.decodeIfPresent(String.self, forKey: .arrival)
        flightTime = try values.decodeIfPresent(String.self, forKey: .flightTime)
        travelTime = try values.decodeIfPresent(String.self, forKey: .travelTime)
        equipment = try values.decodeIfPresent(String.self, forKey: .equipment)
    }
}
