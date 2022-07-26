//
//  SSLComerzResponse.swift
//  flightexpert
//
//  Created by sohan on 7/26/22.
//

import Foundation
import SwiftUI

struct Ssl_response : Codable {
    var aPIConnect : String?
    var amount : String?
    var bank_tran_id : String?
    var base_fair : String?
    var card_brand : String?
    var card_issuer : String?
    var card_issuer_country : String?
    var card_issuer_country_code : String?
    var card_no : String?
    var card_type : String?
    var currency_amount : String?
    var currency_rate : String?
    var currency_type : String?
    var gw_version : String?
    var risk_level : String?
    var risk_title : String?
    var sessionsessionkey : String?
    var status : String?
    var store_amount : String?
    var tran_date : String?
    var tran_id : String?
    var val_id : String?
    var validated_on : String?
    var value_a : String?
    var value_b : String?
    var value_c : String?
    var value_d : String?
}

struct SSLComerzResponse : Codable {
    var uniqueTransID : String?
    var ssl_response : Ssl_response?

}
