//
//  LoginResponse.swift
//  flightexpert
//
//  Created by sohan on 5/19/22.
//

import Foundation

struct LoginResponse : Codable {
    let token : String?
    let refreshToken : String?
    let role : String?
    let expireIn : String?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case refreshToken = "refreshToken"
        case role = "role"
        case expireIn = "expireIn"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        expireIn = try values.decodeIfPresent(String.self, forKey: .expireIn)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}


