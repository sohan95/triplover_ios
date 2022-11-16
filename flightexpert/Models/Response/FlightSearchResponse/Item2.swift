import Foundation
struct Item2 : Codable {
	let apiRef : Int
	let uniqueTransID : String?
	let isSuccess : Bool
	let requestTime : String?
	let responseTime : String?
	let conversionTime : String?
	let timeTicks : Int
	let message : String?
}
