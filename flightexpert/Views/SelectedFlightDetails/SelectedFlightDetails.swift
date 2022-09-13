//
//  RouteConfirmView.swift
//  flightexpert
//
//  Created by sohan on 7/4/22.
//

import SwiftUI

struct SelectedFlightDetails: View {
    //@ObservedObject var flightSearchModel: FlightSearchModel
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    @State var shouldScroll: Bool = true
    @State var spaceValue: CGFloat = 100.0
    @State var selectedFlightList: [Direction] = []
    @State var isSearching: Bool = false
    @State var selection: String? = nil
    @State var showsAlert = false
    @State var failedMsg:String = ""
    
    @State var final_basePrice: Double = 0.0
    @State var final_taxes: Double = 0.0
    @State var final_discountPrice: Double = 0.0
    @State var final_totalPrice: Double = 0.0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                .edgesIgnoringSafeArea(.all)
            
            NavigationLink(destination:TravelerFormView(), tag: "TravelerFormView", selection: $selection) { EmptyView() }
            NavigationLink(destination:SigninView(), tag: "SigninView", selection: $selection) { EmptyView() }
            
            if !isSearching {
                GeometryReader { reader in
                    VStack(spacing:5) {
                        HStack{
                            Spacer()
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                HStack {
                                    Text("HIDE")
                                        .font(.system(size: 12, weight:.bold, design: .rounded))
                                    
                                }
                                .frame(width: 70, height: 30)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 7)
                                .fill(orangeGradient))
                            }
                        }.padding(.trailing, 10)
                        
                        ScrollView(axes, showsIndicators: false) {
                            VStack(spacing:15) {
                                ForEach(0 ..< self.selectedFlightList.count, id:\.self) { i in
                                    let direction: Direction = selectedFlightList[i]
                                    FlightDetailsCell(direction: direction)
//                                        .padding(.vertical, 10)
                                }
                            }
                        }
                        Spacer()
                        HStack {
                            VStack(alignment:.leading, spacing: 5) {
                                Text("Price Details")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .padding(.bottom, 5)
                                HStack(spacing: spaceValue){
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Base Price")
                                        Text("Tax")
                                        Text("Discount")
                                        Text("Total")
                                            .font(.system(size: 11, weight: .bold, design: .rounded))
                                    }
                                    if selectedFlightList.count > 0 {
                                        VStack(alignment: .leading, spacing: 5) {
//                                            Text(": \((selected.bookingComponents?.first?.basePrice)!.removeZerosFromEnd())")
//                                            Text(": \((selected.bookingComponents?.first?.taxes)!.removeZerosFromEnd())")
//                                            Text(": \((selected.bookingComponents?.first?.discountPrice)!.removeZerosFromEnd())")
//                                            Text(": \((selected.bookingComponents?.first?.totalPrice)!.removeZerosFromEnd())")
                                            
                                            Text(": \(self.final_basePrice.removeZerosFromEnd())")
                                            Text(": \(self.final_taxes.removeZerosFromEnd())")
                                            Text(": \(self.final_discountPrice.removeZerosFromEnd())")
                                            Text(": \(self.final_totalPrice.removeZerosFromEnd())")
                                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                        }
                                    }
                                }
                            }
                            .padding()
                            
                            if flightSearchModel.isSelectBtnTapped {
                                Button {
                                    self.ConfirmAction()
                                } label: {
                                    HStack {
                                        Text("CONFIRM")
                                            .font(.system(size: 12, weight:.bold, design: .rounded))
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10, height: 10, alignment: .trailing)
                                    }
                                    .frame(width: 100, height: 30)
                                    .foregroundColor(.white)
                                    .background(RoundedRectangle(cornerRadius: 7)
                                    .fill(blueGradient))
//                                    .padding(.trailing,10)
                                }
                                
                            } else {
                                Spacer()
                            }
                        }
                        .frame(maxWidth:.infinity, minHeight: 150, maxHeight: 150)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .background(.gray.opacity(0.4))
                        Spacer(minLength: 40)
                    }
                    .offset(y: 50)
                    .frame(height: reader.size.height - 50)
                    .clipped()
                    .onAppear() {
                        self.selectedFlightList.removeAll()
                        if flightSearchModel.isSelectBtnTapped {
                            self.spaceValue = 60.0
                            
                            if flightSearchModel.isOneWay {
                                self.selectedFlightList.append(flightSearchModel.selectedFlightList.first!)
                            } else if flightSearchModel.isRoundTrip {
                                for index in flightSearchModel.selectedFlightList.indices where index < (flightSearchModel.searchFlighRequest?.routes.count)! {
                                    self.selectedFlightList.append(flightSearchModel.selectedFlightList[index])
                                }
                            } else if flightSearchModel.isMultiCity {
                                for index in flightSearchModel.selectedFlightList.indices where index < (flightSearchModel.searchFlighRequest?.routes.count)! {
                                    self.selectedFlightList.append(flightSearchModel.selectedFlightList[index])
                                }
                            }
                            
                        } else {
                            self.selectedFlightList.append(flightSearchModel.detailsDir!)
                        }

                        
                        for flight in self.selectedFlightList {
                            self.final_basePrice += flight.bookingComponents?.first?.basePrice ?? 0.0
                            self.final_taxes += flight.bookingComponents?.first?.taxes ?? 0.0
                            self.final_discountPrice += flight.bookingComponents?.first?.discountPrice ?? 0.0
                            self.final_totalPrice += flight.bookingComponents?.first?.totalPrice ?? 0.0
                        }
                    }
                    .alert(isPresented: self.$showsAlert) {
                        Alert(title: Text("Booking failed!"), message: Text(failedMsg), dismissButton: .default(Text("Try Again")))
                    }
                    
                }
                
            } else {
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
                        FakeProgressBar(isActive:flightSearchModel.isSearching)
                            .frame(height: 4)

                    }
                    .padding(.bottom, 64)

                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: btnBack)
        .environmentObject(flightSearchModel)
        
    }
    
    func ConfirmAction() {
        //self.rePriceService()
        
        if flightSearchModel.isSelectBtnTapped {
            let isSignin = UserDefaults.standard.bool(forKey: "isSignin")
            if isSignin {
                var segmentCodeRefs:[String?] = []
                
                for flight in selectedFlightList {
//                    let segmentCodeRefs:[String?] = [
//                        flightSearchModel.originDir?.segmentCodeRef!]
                    segmentCodeRefs.append(flight.segmentCodeRef)
                }
                
                let rePriceRequest: RePriceRequest = RePriceRequest(uniqueTransID: (selectedFlightList.first?.uniqueTransID)!, itemCodeRef: (selectedFlightList.first?.itemCodeRef)!, taxRedemptions: [], segmentCodeRefs: segmentCodeRefs)
                
                self.rePriceStatus(requestBody: rePriceRequest)
                
            } else {
                flightSearchModel.selection = "SigninView"
                //self.selection = "SigninView"
                //self.rePriceService()
            }
        }
    }
    
    func CloseAction() {
        //back Action here
    }
    
    private var axes: Axis.Set {
        return shouldScroll ? .vertical : []
    }
    
    func rePriceStatus(requestBody: RePriceRequest) {
        self.isSearching = true
        HttpUtility.shared.rePriceService(rePriceRequest: requestBody) { result in
            
            DispatchQueue.main.async { [ self] in
                //self.isSearchComplete = true
                self.isSearching = false
                guard (result) != nil else {
                    self.failedMsg = "Error Found!"
                    self.showsAlert.toggle()
                    return
                }
                flightSearchModel.rePriceResponse = result!
                flightSearchModel.totalPrice = self.final_totalPrice
//                SSLCmzViewController.balerPrice = self.final_totalPrice
//                SSLCmzViewController.balerId = (flightSearchModel.rePriceResponse.item1?.uniqueTransID)!
                self.selection = "TravelerFormView"
                
            }
        }
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

struct SelectedFlightDetails_Previews: PreviewProvider {
    static var previews: some View {
        SelectedFlightDetails()
    }
}
