import Foundation
struct Segment : Codable {
	let from : String?
	let fromAirport : String?
	let to : String?
	let toAirport : String?
	let group : Int?
	let departure : String?
	let arrival : String?
	let airline : String?
	let flightNumber : String?
	let segmentCodeRef : String?
	let details : [Details]?
	let serviceClass : String?
	let plane : [String]?
	let duration : [String]?
	let techStops : [Int]?
	let bookingClass : String?
	let bookingCount : String?
	let baggage : [Baggage]?
	let fareBasisCode : String?
	let airlineCode : String?
    
    enum CodingKeys: String, CodingKey {

        case from = "from"
        case fromAirport = "fromAirport"
        case to = "to"
        case toAirport = "toAirport"
        case group = "group"
        case departure = "departure"
        case arrival = "arrival"
        case airline = "airline"
        case flightNumber = "flightNumber"
        case segmentCodeRef = "segmentCodeRef"
        case details = "details"
        case serviceClass = "serviceClass"
        case plane = "plane"
        case duration = "duration"
        case techStops = "techStops"
        case bookingClass = "bookingClass"
        case bookingCount = "bookingCount"
        case baggage = "baggage"
        case fareBasisCode = "fareBasisCode"
        case airlineCode = "airlineCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        fromAirport = try values.decodeIfPresent(String.self, forKey: .fromAirport)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        toAirport = try values.decodeIfPresent(String.self, forKey: .toAirport)
        group = try values.decodeIfPresent(Int.self, forKey: .group)
        departure = try values.decodeIfPresent(String.self, forKey: .departure)
        arrival = try values.decodeIfPresent(String.self, forKey: .arrival)
        airline = try values.decodeIfPresent(String.self, forKey: .airline)
        flightNumber = try values.decodeIfPresent(String.self, forKey: .flightNumber)
        segmentCodeRef = try values.decodeIfPresent(String.self, forKey: .segmentCodeRef)
        details = try values.decodeIfPresent([Details].self, forKey: .details)
        serviceClass = try values.decodeIfPresent(String.self, forKey: .serviceClass)
        plane = try values.decodeIfPresent([String].self, forKey: .plane)
        duration = try values.decodeIfPresent([String].self, forKey: .duration)
        techStops = try values.decodeIfPresent([Int].self, forKey: .techStops)
        bookingClass = try values.decodeIfPresent(String.self, forKey: .bookingClass)
        bookingCount = try values.decodeIfPresent(String.self, forKey: .bookingCount)
        baggage = try values.decodeIfPresent([Baggage].self, forKey: .baggage)
        fareBasisCode = try values.decodeIfPresent(String.self, forKey: .fareBasisCode)
        airlineCode = try values.decodeIfPresent(String.self, forKey: .airlineCode)
    }

}
