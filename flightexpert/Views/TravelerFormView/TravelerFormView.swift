//
//  TravelerFormCell.swift
//  flightexpert
//
//  Created by sohan on 6/8/22.
//

import SwiftUI
//import Combine
//import SSLCommerzSDK

struct TravelerFormView: View {
    
//    @ObservedObject var flightSearchModel: FlightSearchModel
    //@StateObject var bookingDataSource = BookingDataSource()
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    
    @State var totalAdult: Int = 0
    @State var totalChild: Int = 0
    @State var totalInfant: Int = 0
    @State var userDataArray = [UserData]()
    @State var isAgree: Bool = false
    @State var isShowSSLView = false
    @State var showSSLCz: String? = nil
    @State private var data = 3
    @State var showAlert: Bool = false
    @State var alertMsg: String = " "
    
    @State var bottomPadding: CGFloat = 50.0
    @State var bookingConfirmResponse:BookingConfirmResponse?

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
            BackgroundImage
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all, edges: .all)
            
//            NavigationLink(destination:VCRepresented().environmentObject(flightSearchModel), tag: "VCRepresented", selection: $showSSLCz) { EmptyView() }
            NavigationLink(destination:MyBooking().environmentObject(flightSearchModel), tag: "MyBooking", selection: $showSSLCz) { EmptyView() }
            GeometryReader { reader in
                VStack(spacing: 5) {
                    Spacer()
                    ScrollView {
                        ForEach(self.userDataArray.indices, id: \.self) { i in
                            TravelerFormCell(userData: self.$userDataArray[i], isDomestic: flightSearchModel.isDomestic)
                        }
                    }
//                    .offset(y: 64)
//                    .clipped()
                    
                    VStack(alignment: .center, spacing: 10) {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer()
                            Toggle("I agree to the", isOn: $isAgree)
                                .toggleStyle(CheckboxStyle())
                                .foregroundColor(.black)
                                .font(.system(size: 11, weight:.medium, design: .rounded))
                                .padding(.leading,10)
                                .padding(.trailing, 5)
                            Link("Terms and Condition", destination: URL(string: "https://triplover.com/Terms.aspx")!)
                                .font(.system(size: 11, weight:.bold, design: .rounded))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        
                        Button {
                            //Goto Pricing page
                            self.prepareBookingService()
                        } label: {
                            Text("Book and Continue")
                                .font(.system(size: 13, weight:.bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(minWidth:0, maxWidth: .infinity, minHeight: 35, maxHeight: 35)
                            .background(RoundedRectangle(cornerRadius: 17.5)
                                .fill(blueGradient))
                        }
                    }
                    .frame(height: 70)
                    .padding(.horizontal,5)
                    .padding(.bottom, 50)
                }
//                .offset(y: bottomPadding)
                .padding(.top, bottomPadding)
                .frame(height: reader.size.height - (bottomPadding - 50))
                .clipped()
                .onAppear(perform: {
                    //check Device Notch
                    if UIDevice.current.hasNotch {
                        //... consider notch
                        bottomPadding = 50.0
                    } else {
                        bottomPadding = 100.0
                    }
                })
            }
        }
        .navigationTitle("Passenger Details")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: btnBack)
        
        .onAppear {
            print("sohan=\(data)")
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
        .sheet(isPresented: $isShowSSLView) {
            VCRepresented(data: $data, isShownSSL: $isShowSSLView)
           
        }
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text("Info"), message: Text("error failed!"), dismissButton: .default(Text("Close")))
        }
        .environmentObject(flightSearchModel)
    }
    
    func doIt() {
            print("do something")
    }
    
    func setPassengerInfo(userData: UserData) -> PrepareBookingRequest.PassengerInfoes {
        let nameElement = PrepareBookingRequest.PassengerInfoes.NameElement(title: userData.title, firstName: userData.firstName, lastName: userData.lastName, middleName: userData.middleName)
        let contactInfo = PrepareBookingRequest.PassengerInfoes.ContactInfo(email: userData.email, phone: userData.phone, phoneCountryCode: userData.phoneCountryCode, countryCode: userData.countryCode, cityName: userData.cityName)
        let documentInfo = PrepareBookingRequest.PassengerInfoes.DocumentInfo(documentType: userData.documentType, documentNumber: userData.documentNumber, expireDate: getDateString(date: userData.expireDate), frequentFlyerNumber: userData.frequentFlyerNumber, issuingCountry: userData.issuingCountry, nationality: userData.nationality)
        
        let passengerInfo = PrepareBookingRequest.PassengerInfoes(nameElement: nameElement, contactInfo: contactInfo, documentInfo: documentInfo, passengerType: userData.passengerType, gender: userData.gender, dateOfBirth: getDateString(date: userData.dateOfBirth), passengerKey: userData.passengerKey, isLeadPassenger: userData.isLeadPassenger)
        
        return passengerInfo
    }
    
    func prepareBookingService() {
        var passengerInfoes:[PrepareBookingRequest.PassengerInfoes] = []
        for userData in userDataArray {
            let passengerInfo = setPassengerInfo(userData: userData)
            passengerInfoes.append(passengerInfo)
        }
        let prepareBookingRequest = PrepareBookingRequest(passengerInfoes: passengerInfoes,
                                            taxRedemptions: [], priceCodeRef: flightSearchModel.rePriceResponse.item1?.priceCodeRef, uniqueTransID: flightSearchModel.rePriceResponse.item1?.uniqueTransID, itemCodeRef: flightSearchModel.rePriceResponse.item1?.itemCodeRef)
        
        print("prepareBookingRequest=\(prepareBookingRequest)")
        
        flightSearchModel.isBooking = true
        HttpUtility.shared.prepareBooking(requestBody: prepareBookingRequest) { result in

            DispatchQueue.main.async { [self] in
                flightSearchModel.isBooking = false
                
                guard let result = result else {
                    self.showAlert = true
                    self.alertMsg = "There are something wrong. Please try again!"
                    fatalError("There must be a problem decoding the data...")
                }
                
//                SSLCmzViewController.callback = {
//                    (bookingConfirmResponse) in
//                    //print(beatCount)
//                    if bookingConfirmResponse?.message != nil {
//                        self.showAlert = true
//                        self.alertMsg = bookingConfirmResponse?.message! ?? ""
//                    }
//                    isShowSSLView = false
//                }
                flightSearchModel.bookingResponse = result
                print(result)
                
                //call for openSSLCZ
                showSSLCz = "VCRepresented"
                isShowSSLView = true
                
            }
        }
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

struct TravelerFormView_Previews: PreviewProvider {
    static var previews: some View {
//        TravelerFormView()
        TravelerFormView()
    }
}
