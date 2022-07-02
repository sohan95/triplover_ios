//
//  SearchOptionModal.swift
//  flightexpert
//
//  Created by sohan on 7/1/22.
//

import SwiftUI

struct SearchOptionModal: View {
    @Binding var isShowing: Bool
    @Binding var adults: Int
    @Binding var childs: Int
    @Binding var infants: Int
    @Binding var cabinClass: String
    var doneAction : () -> ()
    
    @State private var selectedClass: Int = 0
//    @State private var selectedClass: String = "Economy"
    var cabinClassList: [String] = ["Economy" ,"PremiumEconomy", "Business", "First", "PremiumFirst"]
    
    @State var selectedAdultNumber: Int = 0
    @State var selectedChildNumber: Int = 0
    @State var selectedInfantNumber: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                VStack {
                    HStack() {
                        Text("")
                            .frame(width:60)
                        Spacer()
                        
                        Text("Traveler, Class")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            print("Cancel Btn tapped")
                            isShowing = false
                        } label: {
                            Text("Cancel")
                                .font(.body)
                                .foregroundColor(.red)
                        }
                    }
                    .frame(maxWidth:.infinity, maxHeight:40)
                    .background(Color.gray)
                    
                    VStack(spacing:10){
                        HStack(spacing: 10) {
//                            VStack(alignment:.leading, spacing: 5){
//                                Text("Class")
//                                Picker("Red", selection: $selectedClass) {
//                                    ForEach(cabinClassList, id: \.self) {
//                                        Text($0)
//                                    }
//                                }
//                                Text("Click to change")
//                            }
//                            .frame(minWidth:0, maxWidth: .infinity,maxHeight: 80)
//                            .background(.white)
//                            .addBorder(Color.gray, width: 2, cornerRadius: 10)
                            Menu {
                                Picker(selection: $selectedClass,
                                label: EmptyView()) {
                                    ForEach(0..<cabinClassList.count) {
                                        //Text("\($0) Adults")
                                        Text(self.cabinClassList[$0])
                                    }
                                }
                            } label: {
                                VStack(alignment:.leading, spacing: 5){
                                    Text("Class")
                                    Text(self.cabinClassList[selectedClass])
                                    Text("Click to change")
                                }
                                .padding(5)
                            }
                            .frame(minWidth:0, maxWidth: .infinity, maxHeight: 80)
                            .background(.white)
                            .addBorder(Color.gray, width: 2, cornerRadius: 10)
                            Menu {
                                Picker(selection: $selectedAdultNumber,
                                label: EmptyView()) {
                                    ForEach(0..<10) {
                                        Text("\($0) Adults")
                                    }
                                }
                            } label: {
                                VStack(alignment:.leading, spacing: 5){
                                    Text("ADULT (12+)")
                                    Text("\(selectedAdultNumber) Traveler")
                                    Text("Click to change")
                                }
                                .padding(5)
                            }
                            .frame(minWidth:0, maxWidth: .infinity, maxHeight: 80)
                            .background(.white)
                            .addBorder(Color.gray, width: 2, cornerRadius: 10)
                        }
                        .foregroundColor(.gray)
                        .padding(.horizontal, 15)
                        
                        HStack(spacing: 10) {
                            Menu {
                                Picker(selection: $selectedChildNumber,
                                label: EmptyView()) {
                                    ForEach(0..<8) {
                                        Text("\($0) Children")
                                    }
                                }
                            } label: {
                                VStack(alignment:.leading, spacing: 5){
                                    Text("CHILD (0 - 2)")
                                    Text("\(selectedChildNumber) Traveler")
                                    Text("Click to change")
                                }
                                .padding(5)
                            }
                            .frame(minWidth:0, maxWidth: .infinity,maxHeight: 80)
                            .background(.white)
                            .addBorder(Color.gray, width: 2, cornerRadius: 10)

                            Menu {
                                Picker(selection: $selectedInfantNumber,
                                label: EmptyView()) {
                                    ForEach(0..<5) {
                                        Text("\($0) Infants")
                                    }
                                }
                            } label: {
                                VStack(alignment:.leading, spacing: 5){
                                    Text("INFANT (0 - 2)")
                                    Text("\(selectedInfantNumber) Traveler")
                                    Text("Click to change")
                                }
                                .padding(5)
                            }
                            .frame(minWidth:0, maxWidth: .infinity,maxHeight: 80)
                            .background(.white)
                            .addBorder(Color.gray, width: 2, cornerRadius: 10)
                        }
                        .foregroundColor(.gray)
                        .padding(.horizontal, 15)
                    }
                    
                    Button(action: {
                        adults = selectedAdultNumber
                        childs = selectedChildNumber
                        infants = selectedInfantNumber
                        cabinClass = self.cabinClassList[self.selectedClass]
                        isShowing = false
                        self.doneAction()
                        
                    }, label: {
                        Text("DONE")
                            .frame(maxWidth:.infinity)
                            .padding([.top, .bottom], 12)
                            .background(blueGradient)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    })
                    .padding(.horizontal, 15)
                    
                    Spacer()
                }
                .frame(height: 350)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .transition(.move(edge: .bottom))
            }
            
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
}

struct SearchOptionModal_Previews: PreviewProvider {
    static var previews: some View {
        FlightView()
    }
}
