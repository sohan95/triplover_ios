//
//  AirportDataLoader.swift
//  flightexpert
//
//  Created by sohan on 5/27/22.
//

import Foundation

public class AirportDataLoader {
    @Published var airportList = [AirportData]()
    
    init() {
        load()
        sort()
    }
    
    func load() {
        
        if let fileLocation = Bundle.main.url(forResource: "airports", withExtension: "json") {
            
            // do catch in case of an error
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([AirportData].self, from: data)
                
                self.airportList = dataFromJson
                DispatchQueue.main.async {
                    self.airportList = dataFromJson
                }
            } catch {
                print(error)
            }
        }
    }
    
    func sort() {
        self.airportList = self.airportList.sorted(by: { $0.name < $1.name })
    }
}
