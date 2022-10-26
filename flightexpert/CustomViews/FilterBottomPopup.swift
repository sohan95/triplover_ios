//
//  FilterBottomPopup.swift
//  flightexpert
//
//  Created by sohan on 7/22/22.
//

import SwiftUI



struct FilterBottomPopup: View {
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    @Binding var selectedStop: String;
    @Binding var selectedAirline: String;
    @Binding var selectedMinMaxPrice: MinMaxPrice;
    var minMaxPrice: MinMaxPrice
    @ObservedObject var slider:CustomSlider
    typealias Action = (Bool) -> Void
    var doneFilterAction: Action?
    
    @State var filterTypeIndex: Int = 2
    
    @State var width: Double = 0
    @State var width1: Double = 15
    @State var ratio: Double = 0
    var totalWidth = UIScreen.main.bounds.width - 60
    @State var popupViewHeight: CGFloat = 330.0
    //@ObservedObject var slider: CustomSlider
    //@StateObject var progress: CustomSlider

    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing:10) {
                    // Header Buttons
                    HStack(spacing: 5) {
                        Button {
                            print("Price")
                            self.filterTypeIndex = 0
                        } label: {
                            Text("Price")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical,10)
                                .background(self.filterTypeIndex == 0 ? .gray : Color("colorPrimary"))
                                .cornerRadius(5)
                        }
                        Button {
                            print("Stops")
                            self.filterTypeIndex = 1
                        } label: {
                            Text("Stops")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical,10)
                                .background(self.filterTypeIndex == 1 ? .gray : Color("colorPrimary"))
                                .cornerRadius(5)
                        }

                        Button {
                            print("Airline")
                            self.filterTypeIndex = 2
                        } label: {
                            Text("Airline")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical,10)
                                .background(self.filterTypeIndex == 2 ? .gray : Color("colorPrimary"))
                                .cornerRadius(5)
                        }
                    }
                    .frame(maxWidth:.infinity, maxHeight: 35)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            if filterTypeIndex == 0 { // For stops
                                VStack(alignment: .leading, spacing: 10) {
                                    /*HStack{
                                        Text("\(self.getValue(val:self.width))")
                                        Text("\(self.getValue(val:self.width1))")
                                    }.lineLimit(1)

                                    ZStack(alignment: .leading) {
                                        Color.black.opacity(0.10)
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, maxHeight: 30)
                                            .cornerRadius(10)
                                            
                                        Rectangle()
                                            .fill(Color.black.opacity(0.50))
                                            .frame(height: 6)
                                            .padding(.horizontal,10)
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(width:self.width1 - self.width, height: 6)
                                            .offset(x:self.width + 18)
                                            .padding(.horizontal,10)
                                        
                                        HStack(spacing: 0){
                                            //Circle-1
                                            Circle()
                                                .fill(Color.black)
                                                .frame(width:18, height: 18)
                                                .offset(x: self.width)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({(value) in
                                                            if value.location.x >= 0 && value.location.x <= self.width1 {
                                                                self.width = value.location.x
                                                            }
                                                        })
                                                )
                                            
                                            //Circle-2
                                            Circle()
                                                .fill(Color.black)
                                                .frame(width:18, height: 18)
                                                .offset(x: self.width1)
                                                .gesture(
                                                    
                                                    DragGesture()
                                                        .onChanged({(value) in
                                                            if value.location.x <= totalWidth && value.location.x >= self.width {
                                                                self.width1 = value.location.x
                                                            }
                                                        })
                                                )
                                        }
                                        .padding(.horizontal,10)
                                    }
                                    .padding(.top, 25)*/
                                    HStack{
                                        Text("\(slider.lowHandle.currentValue, specifier: "%.2f")")
                                        Spacer()
                                        Text("\(slider.highHandle.currentValue, specifier: "%.2f")")
                                    }.padding(.trailing,10)
                                    ZStack{
                                        Rectangle()
                                                .fill(Color.gray.opacity(0.5))
                                                .frame(height: 30)
                                        SliderView(slider: slider) 
                                    }
                                    
                                }
                                .frame(maxWidth:.infinity)
                                .padding()
                            }
                            
                            if filterTypeIndex == 1 { // For stops
                                List {
                                ForEach(stopsList,id: \.self){item in
                                    Button(action: {
                                        self.selectedStop = item
                                        //self.doneAction()
                                    }) {
                                        HStack(alignment:.bottom, spacing: 15) {
                                            ZStack(alignment: .center){
                                                Rectangle().stroke(self.selectedStop == item ? Color.black : Color.gray, lineWidth: 2).frame(width: 16, height: 16)

                                                if self.selectedStop == item {
                                                    Rectangle().fill(Color.black).frame(width: 10, height: 10)
                                                }
                                            }
                                            Text(item)
                                                .font(.system(size: 11, weight: .medium, design: .rounded))

                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                                }
//                                .padding(.vertical, 20)
                            }
                            
                            if filterTypeIndex == 2 { // For stops
                                List {
                                ForEach(flightSearchModel.airlineList,id: \.self){item in

                                    Button(action: {
                                        self.selectedAirline = item
                                        //self.doneAction()
                                    }) {
                                        HStack(alignment:.bottom, spacing: 15) {
                                            ZStack(alignment: .center){
                                                Rectangle().stroke(self.selectedAirline == item ? Color.black : Color.gray, lineWidth: 1).frame(width: 16, height: 16)

                                                if self.selectedAirline == item {
                                                    Rectangle().fill(Color.black).frame(width: 10, height: 10)
                                                }
                                            }
                                            Text(item)
                                                .font(.system(size: 11, weight: .medium, design: .rounded))

                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                                }
//                                .padding(.vertical, 20)
                            }
                            
                        }
                        .frame(maxWidth:.infinity, maxHeight: 160)
//                        .background(.yellow)
                        
                        //Footer
                        HStack(spacing: 5) {
                            Button {
                                self.selectedMinMaxPrice = MinMaxPrice(minPrice: slider.lowHandle.currentValue, maxPrice: slider.highHandle.currentValue)
                                if let doneFilterAction = doneFilterAction {
                                    doneFilterAction(false)
                                }
                            } label: {
                                Text("Reset")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding(.vertical,10)
                                    .background(Color("colorPrimary"))
                                    .cornerRadius(5)
                            }
                            Button {
                                print("Apply")
                                if let doneFilterAction = doneFilterAction {
//                                    self.selectedMinMaxPrice = MinMaxPrice(minPrice: width*ratio, maxPrice: width1*ratio)
                                    self.selectedMinMaxPrice = MinMaxPrice(minPrice: slider.lowHandle.currentValue, maxPrice: slider.highHandle.currentValue)
                                    doneFilterAction(true)
                                }
                                
                            } label: {
                                Text("Apply")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding(.vertical,10)
                                    .background(Color("colorPrimary"))
                                    .cornerRadius(5)
                            }
                        }
                        .frame(maxWidth:.infinity, maxHeight:35)
                        .foregroundColor(.white)
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .padding(.vertical,5)
//                        .background(.orange)
                        Spacer()
                    }
                    .frame(maxWidth:.infinity, maxHeight: 250)
//                    .background(.pink)
                    Spacer()
                }
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .padding(.horizontal, 10)
                .frame(maxWidth:.infinity, maxHeight: popupViewHeight)//330
                .background(.white)
            }

        }
        .onAppear(perform: {
            //check Device Notch
            if UIDevice.current.hasNotch {
                //... consider notch
                popupViewHeight = 320.0
            } else {
                popupViewHeight = 370.0
            }
        })
//        .onAppear(){
////            ratio = (minMaxPrice.maxPrice-minMaxPrice.minPrice)/totalWidth
////            width1 = totalWidth
////            print(String(format: "%.2f", ratio))
//            //self.slider = CustomSlider(start: 300, end: 400)
////            self.progress = CustomSlider(start: self.flightSearchModel.minMaxPrice.minPrice, end: self.flightSearchModel.minMaxPrice.maxPrice)
//        }
    }
    
    
    func getValue(val: Double) -> String{
        
        let vall: Double = val * ratio
        return String(format: "%.2f", vall)
    }
}

//struct FilterBottomPopup_Previews: PreviewProvider {
//    static var previews: some View {
////        FilterBottomPopup(selectedStop: .constant("1 Stop"), selectedAirline: .constant("Biman"))
//        let minMaxPrice1 = MinMaxPrice(minPrice: 0.0, maxPrice: 0.0)
//        FilterBottomPopup(selectedStop: .constant("1 Stop"), selectedAirline: .constant("Biman"), selectedMinMaxPrice: .constant(minMaxPrice1), minMaxPrice: minMaxPrice1)
//    }
//}
