import Foundation
struct BookingComponent : Codable {
	let discountPrice : Double
	let totalPrice : Double
	let basePrice : Double
	let taxes : Double
	let ait : Double
	let fareReference : String?
	let agentAdditionalPrice : Double
}
