import Foundation
struct Item2 : Codable {
	let apiRef : Int?
	let uniqueTransID : String?
	let isSuccess : Bool?
	let requestTime : String?
	let responseTime : String?
	let conversionTime : String?
	let timeTicks : Int?
	let message : String?
    let isMessageShow: Bool?
    
    enum CodingKeys: String, CodingKey {

        case apiRef = "apiRef"
        case uniqueTransID = "uniqueTransID"
        case isSuccess = "isSuccess"
        case requestTime = "requestTime"
        case responseTime = "responseTime"
        case conversionTime = "conversionTime"
        case timeTicks = "timeTicks"
        case message = "message"
        case isMessageShow = "isMessageShow"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        apiRef = try values.decodeIfPresent(Int.self, forKey: .apiRef)
        uniqueTransID = try values.decodeIfPresent(String.self, forKey: .uniqueTransID)
        isSuccess = try values.decodeIfPresent(Bool.self, forKey: .isSuccess)
        requestTime = try values.decodeIfPresent(String.self, forKey: .requestTime)
        responseTime = try values.decodeIfPresent(String.self, forKey: .responseTime)
        conversionTime = try values.decodeIfPresent(String.self, forKey: .conversionTime)
        timeTicks = try values.decodeIfPresent(Int.self, forKey: .timeTicks)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        isMessageShow = try values.decodeIfPresent(Bool.self, forKey: .isMessageShow)
    }

}
