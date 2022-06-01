/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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