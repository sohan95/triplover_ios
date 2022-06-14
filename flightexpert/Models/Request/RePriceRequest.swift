//
//  RePriceRequest.swift
//  flightexpert
//
//  Created by sohan on 6/13/22.
//

//    {
//        "uniqueTransID": "USB1127123498",
//        "itemCodeRef": "VVNCMTEyNzEyMzQ5OC02Mzc4NTA4OTM5ODgxMDA1MzV8bE5WZWwvK3BXREtBeFNoS0ZBQUFBQT09fFVhcGlHYWxpbGVv",
//        "taxRedemptions": [],
//        "segmentCodeRefs": [
//           "UE9naGwvQXFXREtBSHZFb0ZBQUFBQT09fFBPZ2hsL0FxV0RLQXV5RW9GQUFBQUE9PXxQT2dobC9BcVdES0FjdUVvRkFBQUFBPT0=",
//           "UE9naGwvQXFXREtBTHZFb0ZBQUFBQT09fFBPZ2hsL0FxV0RLQXl5RW9GQUFBQUE9PXxQT2dobC9BcVdES0FndUVvRkFBQUFBPT0="
//        ]
//    }

import Foundation
struct RePriceRequest: Codable {
    var uniqueTransID : String
    var itemCodeRef : String
    var taxRedemptions : [String?]
    var segmentCodeRefs : [String?]
}
