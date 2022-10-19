//
//  SearchOptionModal.swift
//  flightexpert
//
//  Created by sohan on 7/1/22.
//

import SwiftUI
var cabinClassList: [String] = ["Economy" ,"Premium", "Business", "First Class"]

struct SearchOptionModal: View {
    @Binding var isShowing: Bool
    @Binding var adults: Int
    @Binding var childs: Int
    @Binding var infants: Int
    @Binding var cabinClass: String
    var doneAction : () -> ()
    
    @State var selectedCabin: String = "Economy"
    @State var selectedAdultNumber: Int = 1
    @State var selectedChildNumber: Int = 0
    @State var selectedInfantNumber: Int = 0
    
    @State var maxCabin: Int = 4
    @State var maxAdult: Int = 8
    @State var maxChild: Int = 1
    @State var maxInfants: Int = 0
    
    var totalPassenger: Int = 9
    @State var showRadioList: Bool = false
    @State var buttonIndex: Int = -1
    @State var selectedSortCategory = ""
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }
                
                VStack {
                    // header
                    HStack() {
                        Text("")
                            .frame(width:60)
                        Spacer()
                        
                        Text("Traveler, Class")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            print("Cancel Btn tapped")
                            withAnimation {
                                isShowing = false
                            }
                        } label: {
                            Text("Cancel")
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                .foregroundColor(Color(hex: "#FF5733"))
                        }
                        .padding(.horizontal,10)
                    }
                    .frame(maxWidth:.infinity, maxHeight:40)
                    .background(Color.gray.opacity(0.4))
                    
                    // First Row-Button
                    VStack(alignment: .leading, spacing:10){
                        HStack(spacing: 10) {
                            Button {
                                self.buttonIndex = 0
                                withAnimation {
                                    self.showRadioList = true
                                }
                            } label: {
                                MenuButtonView(title1: "CLASS", title2:selectedCabin)
                            }
                            
                            Button {
                                self.buttonIndex = 1
                                withAnimation {
                                    self.showRadioList = true
                                }
                            } label: {
                                MenuButtonView(title1: "ADULT (12+)", title2:"\(selectedAdultNumber) Traveler")
                            }
                        }
                        .foregroundColor(.gray)
                        .padding(.horizontal, 15)
                        
                        HStack(spacing: 10) {
                            Button {
                                self.buttonIndex = 2
                                withAnimation {
                                    self.showRadioList = true
                                }
                            } label: {
                                MenuButtonView(title1: "CHILD (2 - 12)", title2:"\(selectedChildNumber) Traveler")
                            }
                            
                            Button {
                                self.buttonIndex = 3
                                withAnimation {
                                    self.showRadioList = true
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
                        cabinClass = selectedCabin
                        withAnimation {
                            self.showRadioList.toggle()
                            isShowing = false
                        }
                        self.buttonIndex = -1
                        //self.showRadioList = false
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
                .frame(height: 320)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .transition(.move(edge: .bottom))
                
                // Sort By option popup
                VStack{
                    Spacer()
                    if self.buttonIndex == 0 {
                        CabinClassPopup(title: "Class", selected: $selectedCabin, show: self.$showRadioList) {
                            withAnimation {
                                self.showRadioList.toggle()
                            }
                        }
                        .offset(y: self.showRadioList ? (UIApplication.shared.currentUIWindow()?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                    if self.buttonIndex == 1 {
                        RadioListPopup(title: "Adult", itemName: "Adult", maxNumber: $maxAdult, selected: $selectedAdultNumber, show: self.$showRadioList) {
                            
                            maxChild = totalPassenger - selectedAdultNumber
                            maxInfants = selectedAdultNumber
                            
                            if selectedInfantNumber > selectedAdultNumber {
                                selectedInfantNumber = selectedAdultNumber
                            }
                            withAnimation {
                                self.showRadioList.toggle()
                            }
                        }
                        .offset(y: self.showRadioList ? (UIApplication.shared.currentUIWindow()?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                    else if self.buttonIndex == 2 {
                        RadioListPopup(title: "Child", itemName: "Child", maxNumber: $maxChild, selected: $selectedChildNumber, show: self.$showRadioList) {
                            
                            maxAdult = totalPassenger - selectedChildNumber
                            maxInfants = selectedAdultNumber
                            withAnimation {
                                self.showRadioList.toggle()
                            }
                        }
                        .offset(y: self.showRadioList ? (UIApplication.shared.currentUIWindow()?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                    
                    else if self.buttonIndex == 3 {
                        RadioListPopup(title: "Infants", itemName: "Infants", maxNumber: $maxInfants, selected: $selectedInfantNumber, show: self.$showRadioList) {
                            withAnimation {
                                self.showRadioList.toggle()
                            }
                        }
                        .offset(y: self.showRadioList ? (UIApplication.shared.currentUIWindow()?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                    
                }.background(Color(UIColor.label.withAlphaComponent(self.showRadioList ? 0.3 : 0)).edgesIgnoringSafeArea(.all))
            }
            
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(Animation.easeInOut(duration: 1.0), value: 200.0)
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
        VStack(alignment:.leading, spacing: 5) {
            Text(title1)
                .font(.system(size: 11, weight: .medium, design: .rounded))
            Text(title2)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.black)
            Text("Click to change")
                .font(.system(size: 10, weight: .regular, design: .rounded))
        }
        .frame(minWidth:0, maxWidth: .infinity, minHeight: 75, maxHeight: 75, alignment: .leading)
        .foregroundColor(Color(hex: "#2D2D2D"))
        .padding(.leading, 10)
        .background(.white)
        .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 0.7)
            )
    }
}

//struct MenuButton: View {
//
//    var title1:String
//    var title2:String
//    @Binding var maxNumber:Int
//    @Binding var selectedNumber:Int
//    var doneAction : () -> ()
//    typealias Action = (Int) -> Void
//    var action: Action?
//
//    var body: some View {
//        Menu {
//            Picker(selection: $selectedNumber,
//            label: EmptyView()) {
//                ForEach(0..<maxNumber + 1) {
//                    Text("\($0) Adults")
//                }
//            }.onReceive([self.$selectedNumber].publisher.first()) { value in
//                print("\(value)")
//                self.doneAction()
////                if let action = action {
////                    action(value)
////                }
//            }
//        } label: {
//            MenuButtonView(title1: title1, title2:"\(selectedNumber) Traveler")
//        }
//    }
//}

struct MenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView(title1:"Class", title2: "Economy")
    }
}
