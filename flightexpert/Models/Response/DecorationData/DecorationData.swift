//
//  DecorationData.swift
//  flightexpert
//
//  Created by sohan on 11/12/22.
//

import Foundation

struct DecorationData : Codable {
    struct InitVal : Codable {
        struct Emergency : Codable {
            let notification : String?
            let url : String?
        }

        struct Home : Codable {
            struct Home_offer_place1 : Codable {
                let image : String?
                let link : String?
            }
            struct Home_offer_place2 : Codable {
                let image : String?
                let link : String?
            }
            struct Search_offer_place3 : Codable {
                let image : String?
                let link : String?
            }
            
            let splash : String?
            let background : String?
            let flight_icon : String?
            let hotel_icon : String?
            let tour_icon : String?
            let visa_icon : String?
            let home_offer_place1 : Home_offer_place1?
            let home_offer_place2 : Home_offer_place2?
            let search_offer_place3 : Search_offer_place3?
        }

        let last_updated : String?
        let last_version : String?
        let emergency : Emergency?
        let home : Home?
    }
    
    let initVal : InitVal?

    enum CodingKeys: String, CodingKey {

        case initVal = "init"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        initVal = try values.decodeIfPresent(InitVal.self, forKey: .initVal)
    }

}
