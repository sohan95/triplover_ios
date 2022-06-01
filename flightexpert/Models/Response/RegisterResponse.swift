//
//  RegisterResponse.swift
//  flightexpert
//
//  Created by sohan on 5/31/22.
//

import Foundation

struct RegisterResponse : Decodable {
    let isSuccess : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case isSuccess = "isSuccess"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try values.decodeIfPresent(Bool.self, forKey: .isSuccess)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
