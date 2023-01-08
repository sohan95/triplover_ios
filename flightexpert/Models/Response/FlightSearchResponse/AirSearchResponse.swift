import Foundation
struct AirSearchResponse : Codable, Hashable {
	let uniqueTransID : String?
	let itemCodeRef : String?
	let totalPrice : Double?
	let basePrice : Double?
	let eqivqlBasePrice : Double?
	let taxes : Double?
	let platingCarrierName : String?
	let platingCarrier : String?
	let refundable : Bool?
	let directions : [[Direction]]?
	let bookingComponents : [BookingComponent]?
	let passengerFares : PassengerFares?
	let passengerCounts : PassengerCount?
	let bookable : Bool?
//    let avlSrc: String?
    
    static func == (lhs: AirSearchResponse, rhs: AirSearchResponse) -> Bool {
            return lhs.uniqueTransID == rhs.uniqueTransID
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueTransID)
    }

    enum CodingKeys: String, CodingKey {

        case uniqueTransID = "uniqueTransID"
        case itemCodeRef = "itemCodeRef"
        case totalPrice = "totalPrice"
        case basePrice = "basePrice"
        case eqivqlBasePrice = "eqivqlBasePrice"
        case taxes = "taxes"
        case platingCarrierName = "platingCarrierName"
        case platingCarrier = "platingCarrier"
        case refundable = "refundable"
        case directions = "directions"
        case bookingComponents = "bookingComponents"
        case passengerFares = "passengerFares"
        case passengerCounts = "passengerCounts"
        case bookable = "bookable"
//        case avlSrc = "avlSrc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uniqueTransID = try values.decodeIfPresent(String.self, forKey: .uniqueTransID)
        itemCodeRef = try values.decodeIfPresent(String.self, forKey: .itemCodeRef)
        totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(Double.self, forKey: .basePrice)
        eqivqlBasePrice = try values.decodeIfPresent(Double.self, forKey: .eqivqlBasePrice)
        taxes = try values.decodeIfPresent(Double.self, forKey: .taxes)
        platingCarrierName = try values.decodeIfPresent(String.self, forKey: .platingCarrierName)
        platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
        refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
        directions = try values.decodeIfPresent([[Direction]].self, forKey: .directions)
        bookingComponents = try values.decodeIfPresent([BookingComponent].self, forKey: .bookingComponents)
        passengerFares = try values.decodeIfPresent(PassengerFares.self, forKey: .passengerFares)
        passengerCounts = try values.decodeIfPresent(PassengerCount.self, forKey: .passengerCounts)
        bookable = try values.decodeIfPresent(Bool.self, forKey: .bookable)
//        avlSrc = try values.decodeIfPresent(String.self, forKey: .avlSrc)
    }

}
