//
//  BookingDataSource.swift
//  flightexpert
//
//  Created by sohan on 6/11/22.
//

import Foundation

class BookingDataSource: ObservableObject {
    //@Published var prepareBookingRequest:PrepareBookingRequest = PrepareBookingRequest()
    @Published var userDataList = [UserData]()
    
    @Published var bookingResponse: BookingResponse?
    @Published var isBooking: Bool = false

    
    func postBookingData(requestBody:PrepareBookingRequest) {
        self.isBooking = true
        HttpUtility.shared.prepareBooking(requestBody: requestBody) { result in

            DispatchQueue.main.async { [self] in
                self.isBooking = false
                
                guard let result = result else {
                    fatalError("There must be a problem decoding the data...")
                }
                
                self.bookingResponse = result
                print(result)
            }
        }
    }
    
}
