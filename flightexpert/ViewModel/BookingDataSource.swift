//
//  BookingDataSource.swift
//  flightexpert
//
//  Created by sohan on 6/11/22.
//

import Foundation

class BookingDataSource: ObservableObject {
    @Published var bookingRequest:BookingRequest = BookingRequest()
    @Published var userDataList = [UserData]()
    
    @Published var bookingResponse: BookingResponse?
    @Published var isBooking: Bool = false

    
    func postBookingData(requestBody:BookingRequest) {
        self.isBooking = true
        HttpUtility.shared.bookingService(bookingRequest: requestBody) { result in

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
