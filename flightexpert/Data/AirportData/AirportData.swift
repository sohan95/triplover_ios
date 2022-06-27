//
//  AirportData.swift
//  flightexpert
//
//  Created by sohan on 5/6/22.


import Foundation

struct AirportData: Hashable, Codable {
    var name: String = String()
    var city: String = String()
    var country: String = String()
    var iata: String = String()
}

struct RouteData: Hashable, Codable {
    var source: AirportData
    var destination: AirportData
    var travelDate: Date
}


