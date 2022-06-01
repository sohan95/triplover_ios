//
//  AirportInfo.swift
//  flightexpert
//
//  Created by sohan on 5/25/22.
//


import SwiftUI

struct AirportInfo: Decodable {
    let name: String
    let city: String
    let country: String
    let iata: String
}

//let sampleAirportData: [AirportInfo] = [
//    AirportInfo(name: "Madang",
//                city: "Madang",
//                country: "Papua New Guinea",
//                iata: "MAG")
//]
