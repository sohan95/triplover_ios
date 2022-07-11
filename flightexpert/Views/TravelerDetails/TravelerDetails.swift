//
//  UserFormView.swift
//  flightexpert
//
//  Created by sohan on 6/8/22.
//

import SwiftUI

struct TravelerDetails: View {
    
//    @ObservedObject var flightSearchModel: FlightSearchModel
    //@StateObject var bookingDataSource = BookingDataSource()
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    
    @State var totalAdult: Int = 0
    @State var totalChild: Int = 0
    @State var totalInfant: Int = 0
    @State var userDataArray = [UserData]()
    @State var isAgree: Bool = false

    @Environment(\.presentationMode) var presentationMode
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image(systemName: "arrow.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.white

            VStack {
                ScrollView {
                    ForEach(self.userDataArray.indices, id: \.self) { i in
                        UserFormView(passengerInfo: self.$userDataArray[i])
                    }
//                    ForEach((1...totalUserCount), id: \.self) {
//
//                        UserFormView(userTitle: "USER # \($0)", passengerInfo: $userDataArray[$0])
////                    }
//                    VStack {
//
//                        UserFormView(userTitle: "USER # 1", passengerInfo:$userData1)
////                        UserFormView(userTitle: "USER # 2", passengerInfo: $userData2)
////                        UserFormView(userTitle: "USER # 2", passengerInfo: $userData2)
////                        UserFormView(userTitle: "USER # 2", passengerInfo: $userData2)
//                    }
                }
                
                VStack {
                    HStack(spacing: -10) {

                        Toggle("I agree to the", isOn: $isAgree)
                            .toggleStyle(CheckboxStyle())
                            .foregroundColor(.black)
                          .frame(width:150)
                          .padding(.leading,10)


                        NavigationLink("Terms and Condition", destination: SignupView())
                            .font(.headline)
                            .foregroundColor(.black)

                        Spacer()
                    }


                    HStack {
                        Spacer()
                        Button("Book and Continue") {
                            //Goto Pricing page
                            PrepareBooking()
                        }
                        .font(.system(size: 16, weight:.bold, design: .monospaced))
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height: 50)
                    .background(.black)
                }
            }
        }
        .navigationTitle("Traveler Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .onAppear {
//            for i in 1...self.totalUserCount {
//                print("\(i)")
//                self.userDataArray.append(UserData())
//                print("totalCount=\(self.userDataArray.count)")
//            }
            
            //initialize data
            guard (flightSearchModel.rePriceResponse.item1?.passengerCounts) != nil else {
                return
            }
            
           let passengerCounts = flightSearchModel.rePriceResponse.item1?.passengerCounts
            totalAdult = passengerCounts!.adt
            totalChild = passengerCounts!.cnn
            totalInfant = passengerCounts!.inf
            
            
            if (totalAdult > 0){
                for n in 1...totalAdult {
                    print(n)
                    var userData = UserData()
                    userData.userType = "Adult #\(n)"
                    self.userDataArray.append(userData)
                    print(self.userDataArray.count)
                }
            }
            if (totalChild > 0){
                for n in 1...totalChild {
                    print(n)
                    var child = UserData()
                    child.userType = "Child #\(n)"
                    self.userDataArray.append(child)
                    print(self.userDataArray.count)
                }
            }
                
            if (totalInfant > 0) {
                for n in 1...totalInfant {
                    print(n)
                    var infant = UserData()
                    infant.userType = "Infant #\(n)"
                    self.userDataArray.append(infant)
                    print(self.userDataArray.count)
                }
            }
        }
        .environmentObject(flightSearchModel)
    }
    
    func setPassengerInfo(userData: UserData) -> PrepareBookingRequest.PassengerInfoes {
        let nameElement = PrepareBookingRequest.PassengerInfoes.NameElement(title: userData.title, firstName: userData.firstName, lastName: userData.lastName, middleName: userData.middleName)
        let contactInfo = PrepareBookingRequest.PassengerInfoes.ContactInfo(email: userData.email, phone: userData.phone, phoneCountryCode: userData.phoneCountryCode, countryCode: userData.countryCode, cityName: userData.cityName)
        let documentInfo = PrepareBookingRequest.PassengerInfoes.DocumentInfo(documentType: userData.documentType, documentNumber: userData.documentNumber, expireDate: getDateString(date: userData.expireDate), frequentFlyerNumber: userData.frequentFlyerNumber, issuingCountry: userData.issuingCountry, nationality: userData.nationality)
        
        let passengerInfo = PrepareBookingRequest.PassengerInfoes(nameElement: nameElement, contactInfo: contactInfo, documentInfo: documentInfo, passengerType: userData.passengerType, gender: userData.gender, dateOfBirth: getDateString(date: userData.dateOfBirth), passengerKey: userData.passengerKey, isLeadPassenger: userData.isLeadPassenger)
        
        return passengerInfo
    }
    
    func PrepareBooking() {
        var passengerInfoes:[PrepareBookingRequest.PassengerInfoes] = []
        for userData in userDataArray {
            let passengerInfo = setPassengerInfo(userData: userData)
            passengerInfoes.append(passengerInfo)
        }
        let prepareBookingRequest = PrepareBookingRequest(passengerInfoes: passengerInfoes,
                                            taxRedemptions: [], priceCodeRef: flightSearchModel.rePriceResponse.item1?.priceCodeRef, uniqueTransID: flightSearchModel.rePriceResponse.item1?.uniqueTransID, itemCodeRef: flightSearchModel.rePriceResponse.item1?.itemCodeRef)
        
        print(prepareBookingRequest)
        
        flightSearchModel.prepareBooking(requestBody: prepareBookingRequest)
    }
    
    func getDateString(date:Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd"
        //2022-06-29

        // Convert Date to String
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        return dateString
    }
}

struct TravelerDetails_Previews: PreviewProvider {
    static var previews: some View {
//        TravelerDetails()
        TravelerDetails()
    }
}


//struct TravelerDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFormView(title: "UserFormView", flightSearchModel: FlightSearchModel())
//    }
//}
