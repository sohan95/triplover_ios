//
//  MyBooking.swift
//  flightexpert
//
//  Created by sohan on 6/28/22.
//

import SwiftUI

struct MyBooking: View {
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    let btnImgWidth2: Double = 20.0
    
    @State var isLoading:Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @State var currentBookingList: [AirTicketingResponse] = []
    @State private var selection: String? = nil
    @State var selectedBookedFlight: AirTicketingResponse? = nil
    
    @State var showErrorAlert = false
    
    var body: some View {
        ZStack {
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            NavigationLink(destination:BookedFlightDetails(selectedBookedFlight: selectedBookedFlight), tag: "BookedFlightDetails", selection: $selection) { EmptyView() }
            
            if !isLoading {
                if !showErrorAlert {
                    VStack {
                        Spacer()
                        ScrollView {
                            VStack(spacing: 5) {
                                ForEach(currentBookingList, id: \.self) { bookedFlight in
                                    BookedFlight(flight: bookedFlight) { bookedFlight in
                                        selectedBookedFlight = bookedFlight
                                        selection = "BookedFlightDetails"
                                    }
                                }
                            }
                        }
                        .offset(y: 64)
                        .clipped()
                        .frame(minHeight: 480, maxHeight:.infinity)
                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationBarBackButtonHidden(true)
                        Spacer()
                        HStack(alignment: .center, spacing: 70) {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                VStack{
                                    Image(systemName: "house")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: btnImgWidth2)
                                    Text("Home")
                                        .padding(.top, -2)
                                        .font(.system(size: 11, weight: .semibold))
                                }
                            }
                            
                            Button {
                            } label: {
                                VStack{
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: btnImgWidth2)
                                    Text("My Booking")
                                        .padding(.top, -2)
                                        .font(.system(size: 11, weight: .semibold))
                                }
                            }
                            
                            NavigationLink {
                                SigninView()
                            } label: {
                                VStack{
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: btnImgWidth2)
                                    Text("Login")
                                        .padding(.top, -2)
                                        .font(.system(size: 11, weight: .semibold))
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(Color("colorPrimary"))
                        .accentColor(.white)
                        .padding(.bottom, 44)
                    }
                }
                else {
                    VStack(alignment: .center){
                        Spacer()
                        Text("No Data Found")
                        Spacer()
                    }
                }
                
            }
            else {
                ZStack {
                    SplashScreenBg
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 40) {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            .scaleEffect(2)
                        ProgressBar(isActive: $isLoading)
                            .frame(height: 3)
                            
                    }
                    .padding(.bottom, 64)
                    
                }
                
            }
        }
        .onAppear() {
            if selectedBookedFlight != nil {
                self.showErrorAlert = false
                return
            }
            getAllAirTicketList()
        }
    }
    
    func getAllAirTicketList() {
        
        self.isLoading = true
        
        let airTicketingRequest:AirTicketingRequest = AirTicketingRequest(pnr: "", uniqueTransID: "", status: "", fromDate: "", toDate: "", ticketNumber: "")
        
        HttpUtility.shared.AirTicketing(requestBody: airTicketingRequest) { result in

            DispatchQueue.main.async { [self] in
                self.isLoading = false
                
                guard let result = result else {
                    self.showErrorAlert.toggle()
                    return
                    //fatalError("There must be a problem decoding the data...")
                }
                self.showErrorAlert = false
                flightSearchModel.bookedAirTicketList = result
                self.currentBookingList = flightSearchModel.bookedAirTicketList
                print(result)
            }
        }
    }
}

struct MyBooking_Previews: PreviewProvider {
    static var previews: some View {
        MyBooking()
    }
}
