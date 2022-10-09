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
        loadLocalJson()
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
    
    func loadLocalJson() {

            if let path = Bundle.main.path(forResource: "airports", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let dataFromJson = try JSONDecoder().decode([AirportData].self, from: data)
                    self.airportList = dataFromJson
                    DispatchQueue.main.async() { () -> Void in
                        self.airportList = dataFromJson
                    }

                } catch let error {
                    print("parse error: \(error.localizedDescription)")
                }
            } else {
                print("Invalid filename/path.")
            }
        }
    
    func sort() {
        self.airportList = self.airportList.sorted(by: { $0.name < $1.name })
    }
}
