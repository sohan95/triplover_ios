import Foundation
struct Segment : Codable {
	let from : String?
	let fromAirport : String?
	let to : String?
	let toAirport : String?
	let group : Int
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
}
