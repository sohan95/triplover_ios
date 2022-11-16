import Foundation
struct AirSearchResponse : Codable, Hashable {
	let uniqueTransID : String?
	let itemCodeRef : String?
	let totalPrice : Double
	let basePrice : Double
	let eqivqlBasePrice : Double
	let taxes : Double
	let platingCarrierName : String?
	let platingCarrier : String?
	let refundable : Bool
	let directions : [[Direction]]?
	let bookingComponents : [BookingComponent]?
	let passengerFares : PassengerFares?
	let passengerCounts : PassengerCount?
	let bookable : Bool
    
    static func == (lhs: AirSearchResponse, rhs: AirSearchResponse) -> Bool {
            return lhs.uniqueTransID == rhs.uniqueTransID
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueTransID)
    }

}
