import Foundation
struct Item1 : Codable {
	let airSearchResponses : [AirSearchResponse]?
	let airlineFilters : [AirlineFilter]?
	let minMaxPrice : MinMaxPrice?
	let stops : [Int]?
	let totalFlights : Int
    let currency : String?

}
