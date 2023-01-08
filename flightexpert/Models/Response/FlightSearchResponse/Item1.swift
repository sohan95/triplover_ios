import Foundation
struct Item1 : Codable {
	let airSearchResponses : [AirSearchResponse]?
	let airlineFilters : [AirlineFilter]?
	let minMaxPrice : MinMaxPrice?
	let stops : [Int]?
	let totalFlights : Int?
    let currency : String?
    
    enum CodingKeys: String, CodingKey {

        case airSearchResponses = "airSearchResponses"
        case airlineFilters = "airlineFilters"
        case minMaxPrice = "minMaxPrice"
        case stops = "stops"
        case totalFlights = "totalFlights"
        case currency = "currency"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airSearchResponses = try values.decodeIfPresent([AirSearchResponse].self, forKey: .airSearchResponses)
        airlineFilters = try values.decodeIfPresent([AirlineFilter].self, forKey: .airlineFilters)
        minMaxPrice = try values.decodeIfPresent(MinMaxPrice.self, forKey: .minMaxPrice)
        stops = try values.decodeIfPresent([Int].self, forKey: .stops)
        totalFlights = try values.decodeIfPresent(Int.self, forKey: .totalFlights)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
    }

}
