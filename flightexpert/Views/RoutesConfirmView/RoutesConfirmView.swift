//
//  RouteConfirmView.swift
//  flightexpert
//
//  Created by sohan on 7/4/22.
//

import SwiftUI

struct RoutesConfirmView: View {
    @ObservedObject var flightSearchModel: FlightSearchModel
    @State var shouldScroll: Bool = true
    @State var spaceValue: CGFloat = 100.0
    
    var body: some View {
        ZStack {
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            if let selected = self.flightSearchModel.originDir {
                VStack() {
                    ScrollView(axes, showsIndicators: false) {
                        VStack(spacing:15) {
                            ForEach(0 ..< 3, id:\.self) { i in
                                FlightDetailsCell(selected: selected)
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                    .offset(y: 60)
                    .clipped()
                    
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
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(": \((selected.bookingComponents?[0].basePrice)!.removeZerosFromEnd())")
                                    Text(": \((selected.bookingComponents?[0].taxes)!.removeZerosFromEnd())")
                                    Text(": \((selected.bookingComponents?[0].discountPrice)!.removeZerosFromEnd())")
                                    Text(": \((selected.bookingComponents?[0].totalPrice)!.removeZerosFromEnd())")
                                        .font(.system(size: 14, weight: .bold, design: .rounded))
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
                                        .font(.system(size: 14, weight:.bold, design: .rounded))
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .font(.system(size: 10, weight:.semibold))
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
            }
        }
        .onAppear() {
            if flightSearchModel.isSelectBtnTapped {
                self.spaceValue = 60.0
            }
        }
    }
    
    func ConfirmAction() {
        //self.rePriceService()
        
        if flightSearchModel.isSelectBtnTapped {
            let isSignin = UserDefaults.standard.bool(forKey: "isSignin")
            if isSignin {
                self.rePriceService()
//                flightSearchModel.selection = "UserForm"
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
    
    func rePriceService() {
        let segmentCodeRefs:[String?] = [
            flightSearchModel.originDir?.segmentCodeRef!]
        
        let rePriceRequest: RePriceRequest = RePriceRequest(uniqueTransID: (flightSearchModel.originDir?.uniqueTransID)!, itemCodeRef: (flightSearchModel.originDir?.itemCodeRef)!, taxRedemptions: [], segmentCodeRefs: segmentCodeRefs)
        
        //flightSearchModel.isSearching = true
        flightSearchModel.rePriceStatus(requestBody: rePriceRequest)
    }
    private var axes: Axis.Set {
        return shouldScroll ? .vertical : []
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
        RoutesConfirmView(flightSearchModel: FlightSearchModel())
    }
}
