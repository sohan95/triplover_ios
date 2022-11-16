import Foundation
struct Direction : Codable, Hashable  {
    let id = UUID().uuidString
    
	var from : String?
	var to : String?
	var fromAirport : String?
	var toAirport : String?
	var platingCarrierCode : String?
	var platingCarrierName : String?
	var stops : Int
	var segments : [Segment]?
    
    var uniqueTransID : String?
    var itemCodeRef : String?
    var segmentCodeRef: String?
    var bookingComponents : [BookingComponent]?
    var totalPrice : Double
    var departure: String?
    
    static func == (lhs: Direction, rhs: Direction) -> Bool {
        return lhs.id == rhs.id
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
