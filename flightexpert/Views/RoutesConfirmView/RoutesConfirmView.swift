//
//  RouteConfirmView.swift
//  flightexpert
//
//  Created by sohan on 7/4/22.
//

import SwiftUI

struct RoutesConfirmView: View {
    //@ObservedObject var flightSearchModel: FlightSearchModel
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    @State var shouldScroll: Bool = true
    @State var spaceValue: CGFloat = 100.0
    @State var selectedFlightList: [Direction] = []
    @State var isSearching: Bool = false
    @State var selection: String? = nil
    @State var showsAlert = false
    @State var failedMsg:String = ""
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
            
            NavigationLink(destination:TravelerDetails(), tag: "TravelerDetails", selection: $selection) { EmptyView() }
            NavigationLink(destination:SigninView(), tag: "SigninView", selection: $selection) { EmptyView() }
            
            if !isSearching {
                
                VStack() {
                    HStack{
                        Spacer()
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Text("HIDE")
                                    .font(.system(size: 11, weight:.bold, design: .rounded))
                                
                            }
                            .frame(width: 60, height: 30)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 7)
                            .fill(blueGradient))
                        }
                    }
                    ScrollView(axes, showsIndicators: false) {
                        VStack(spacing:15) {
                            ForEach(0 ..< self.selectedFlightList.count, id:\.self) { i in
                                let direction: Direction = selectedFlightList[i]
                                FlightDetailsCell(direction: direction)
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        VStack(alignment:.leading, spacing: 5){
                            Text("Price Details")
                                .font(.system(size: 16, weight: .heavy, design: .rounded))
                                .padding(.bottom,10)
                            HStack(spacing: spaceValue){
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Base Price")
                                    Text("Tax")
                                    Text("Discount")
                                    Text("Total")
                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                }
                                if let selected = selectedFlightList.first {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(": \((selected.bookingComponents?.first?.basePrice)!.removeZerosFromEnd())")
                                        Text(": \((selected.bookingComponents?.first?.taxes)!.removeZerosFromEnd())")
                                        Text(": \((selected.bookingComponents?.first?.discountPrice)!.removeZerosFromEnd())")
                                        Text(": \((selected.bookingComponents?.first?.totalPrice)!.removeZerosFromEnd())")
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                    }
                                }
                            }
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                        }
                        .padding()
                        
                        if flightSearchModel.isSelectBtnTapped {
                            Button {
                                self.ConfirmAction()
                            } label: {
                                HStack {
                                    Text("CONFIRM")
                                        .font(.system(size: 11, weight:.bold, design: .rounded))
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 5, weight:.semibold))
                                }
                                .frame(width: 120, height: 30)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 7)
                                .fill(blueGradient))
                            }
                            
                        } else {
                            Spacer()
                        }
                    }
                    .frame(maxWidth:.infinity, minHeight: 150, maxHeight: 150)
                    .background(.secondary)
                    Spacer(minLength: 40)
                }
                .offset(y: 60)
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
                }
                .alert(isPresented: self.$showsAlert) {
                    Alert(title: Text("Booking failed!"), message: Text(failedMsg), dismissButton: .default(Text("Try Again")))
                }
            } else {
                LoadingView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
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
                self.selection = "TravelerDetails"
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

struct RoutesConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesConfirmView()
    }
}
