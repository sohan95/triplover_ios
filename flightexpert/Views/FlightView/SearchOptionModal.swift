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
    var cabinClassList: [String] = ["Economy" ,"Premium", "Business", "First Class"]
    
    @State var selectedAdultNumber: Int = 1
    @State var selectedChildNumber: Int = 0
    @State var selectedInfantNumber: Int = 0
    
    @State var maxAdult: Int = 8
    @State var maxChild: Int = 1
    @State var maxInfants: Int = 0
    
    var totalPassenger: Int = 9
    
    
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
                    //header
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
                                .foregroundColor(Color(hex: "#FF5733"))
                        }
                        .padding(.horizontal,10)
                    }
                    .frame(maxWidth:.infinity, maxHeight:40)
                    .background(Color.gray)
                    
                    VStack(spacing:10){
                        HStack(spacing: 10) {
                            Menu {
                                Picker(selection: $selectedClass,
                                label: EmptyView()) {
                                    ForEach(0..<cabinClassList.count) {
                                        //Text("\($0) Adults")
                                        Text(self.cabinClassList[$0])
                                    }
                                }

                            } label: {
                                MenuButtonView(title1: "Class", title2: self.cabinClassList[selectedClass])
                            }
                            MenuButton(title1: "ADULT (12+)", title2: "\(selectedAdultNumber) Traveler", maxNumber: $maxAdult, selectedNumber: $selectedAdultNumber) {
                                
                                self.maxChild = totalPassenger - selectedAdultNumber
                                self.maxAdult = totalPassenger - selectedChildNumber
                                self.maxInfants = selectedAdultNumber
                                
                                print("maxAdult=\(maxAdult)maxChild=\(maxChild)maxInfants=\(maxInfants)")
                                print("selectedAdultNumber=\(selectedAdultNumber)  selectedChildNumber=\(selectedChildNumber)")
                            }
                            
//                            Menu {
//                                Picker(selection: $selectedAdultNumber,
//                                label: EmptyView()) {
//                                    ForEach(0..<maxAdult+1) {
//                                        Text("\($0) Adults")
//                                    }
//                                }.onReceive([self.$selectedAdultNumber].publisher.first()) { value in
//                                    print("\(selectedAdultNumber)")
//                                    self.updateAdults()
//                                }
//                            } label: {
//                                MenuButtonView(title1: "ADULT (12+)", title2:"\(selectedAdultNumber) Traveler")
//                            }
                        }
                        .foregroundColor(.gray)
                        .padding(.horizontal, 15)
                        
                        HStack(spacing: 10) {
                            MenuButton(title1: "CHILD (2 - 12)", title2: "\(selectedChildNumber) Traveler", maxNumber: $maxChild, selectedNumber: $selectedChildNumber) {
                                self.updateChilds()
                            }
//                            Menu {
//                                Picker(selection: $selectedChildNumber,
//                                label: EmptyView()) {
//                                    ForEach(0..<maxChild+1) {
//                                        Text("\($0) Children")
//                                    }
//                                }.onReceive([self.$selectedChildNumber].publisher.first()) { value in
//                                    print("\($selectedChildNumber)")
//                                    self.updateChilds()
//                                }
//                            } label: {
//                                MenuButtonView(title1: "CHILD (2 - 12)", title2:"\(selectedChildNumber) Traveler")
//                            }

                            Menu {
                                Picker(selection: $selectedInfantNumber,
                                label: EmptyView()) {
                                    ForEach(0..<maxInfants+1) {
                                        Text("\($0) Infants")
                                    }
                                }
                            } label: {
                                MenuButtonView(title1: "INFANTS (0 - 2)", title2:"\(selectedInfantNumber) Traveler")
                            }
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
        .onAppear(){
            maxAdult = 9
            maxChild = totalPassenger-selectedAdultNumber
            maxInfants = selectedAdultNumber
            
            print("maxAdult=\(maxAdult)maxChild=\(maxChild)maxInfants=\(maxInfants)")
            
        }
    }
    
    func updateAdults() {
        self.maxChild = totalPassenger - selectedAdultNumber
        self.maxAdult = totalPassenger - selectedChildNumber
        self.maxInfants = selectedAdultNumber
        
        print("maxAdult=\(maxAdult)maxChild=\(maxChild)maxInfants=\(maxInfants)")
        print("selectedAdultNumber=\(selectedAdultNumber)  selectedChildNumber=\(selectedChildNumber)")
    }
    
    func updateChilds() {
        self.maxAdult = totalPassenger-selectedChildNumber
        self.maxInfants = selectedAdultNumber
        self.maxChild = totalPassenger - selectedAdultNumber
        print("maxAdult=\(maxAdult)maxChild=\(maxChild)maxInfants=\(maxInfants)")
        print("selectedAdultNumber=\(selectedAdultNumber)  maxChild=\(selectedChildNumber)")
    }

}

struct MenuButtonView: View {

    var title1:String
    var title2:String

    var body: some View {
        VStack(alignment:.leading, spacing: 5){
            Text(title1)
                .font(.system(size: 14, weight: .medium, design: .rounded))
            Text(title2)
                .font(.system(size: 16, weight: .bold, design: .rounded))
            Text("Click to change")
                .font(.system(size: 12, weight: .regular, design: .rounded))
        }
        .frame(minWidth:0, maxWidth: .infinity,minHeight: 80, maxHeight: 80)
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            )
    }
}

struct MenuButton: View {

    var title1:String
    var title2:String
    @Binding var maxNumber:Int
    @Binding var selectedNumber:Int
    var doneAction : () -> ()
    typealias Action = (Int) -> Void
    var action: Action?

    var body: some View {
        Menu {
            Picker(selection: $selectedNumber,
            label: EmptyView()) {
                ForEach(0..<maxNumber+1) {
                    Text("\($0) Adults")
                }
            }.onReceive([self.$selectedNumber].publisher.first()) { value in
                print("\(value)")
                self.doneAction()
//                if let action = action {
//                    action(value)
//                }
            }
        } label: {
            MenuButtonView(title1: "ADULT (12+)", title2:"\(selectedNumber) Traveler")
        }
    }
}

struct MenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView(title1:"Class", title2: "Economy")
    }
}
