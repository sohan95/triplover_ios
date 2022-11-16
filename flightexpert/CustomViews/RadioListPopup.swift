//
//  RadioListPopup.swift
//  flightexpert
//
//  Created by sohan on 8/9/22.
//

import SwiftUI

struct RadioListPopup: View {
    var title: String
    var itemName: String
    @Binding var maxNumber: Int
    @Binding var selected: Int
    @Binding var show: Bool
    
    var itemList: [String] = ["0","1","2","3","4","5","6","7","8","9"]
    
    var doneAction : () -> ()
    
    var body : some View {
        
        VStack{
            VStack(alignment:.leading, spacing: 10){
                VStack (alignment: .leading){
                    Text(title)
                        .font(.system(size: 15, weight: .semibold , design: .rounded))
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                    Divider()
                        .frame(height: 0.5)
                     .background(.black.opacity(0.7))
                    
                }
                VStack(alignment:.leading) {
                    ForEach(itemList,id: \.self){ item in
                        if (Int(item)! <= maxNumber){
                            Button(action: {
                                self.selected = Int(item)!
                                self.doneAction()
                            }) {
                                HStack(alignment:.center, spacing: 15) {
                                    ZStack(alignment: .center){
                                        Circle().stroke(self.selected == Int(item)! ? Color.black : Color.gray, lineWidth: 1).frame(width: 15, height: 15)
                                        
                                        if self.selected == Int(item)! {
                                            Circle().fill(Color.black).frame(width: 10, height: 10)
                                        }
                                    }
                                    Text("\(item) \(itemName)")
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                }
                                .foregroundColor(.black)
                            }
                        }
                    }
                }
                .padding(.horizontal,20)
                VStack(spacing: 0){
                    Divider()
                        .frame(height: 0.5)
                     .background(.black.opacity(0.7))
                    HStack{
                        Spacer()
                         Button(action: {
                             withAnimation {
                                 self.show.toggle()
                             }
                         }) {
                             Text("CLOSE")
                                 .padding(.vertical, 12)
                                 .font(.system(size: 13, weight: .semibold, design: .rounded))
                                 .foregroundColor(.black.opacity(0.7))
                         }
                         .padding(.trailing, 20)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(5)
            .padding(.horizontal,40)
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
        }
        .padding(.bottom,(UIApplication.shared.currentUIWindow()?.safeAreaInsets.bottom)! + UIScreen.main.bounds.height/3)
        .foregroundColor(.black.opacity(0.7))
    }
}

struct CabinClassPopup: View {
    var title: String
    @Binding var selected: String
    @Binding var show: Bool
    
    var doneAction : () -> ()
    
    var body : some View {
        
        VStack{
            VStack(spacing:10){
                VStack (alignment: .leading){
                    Text(title)
                        .font(.system(size: 15, weight: .semibold , design: .rounded))
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                    Divider()
                        .frame(height: 0.5)
                     .background(.black.opacity(0.7))
                    
                }
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(cabinClassList,id: \.self){ item in
                        Button(action: {
                            self.selected = item
                            self.doneAction()
                        }) {
                            HStack(alignment:.center, spacing: 15) {
                                ZStack(alignment: .center){
                                    Circle().stroke(self.selected == item ? Color.black : Color.gray, lineWidth: 1).frame(width: 15, height: 15)
                                    
                                    if self.selected == item {
                                        Circle().fill(Color.black).frame(width: 10, height: 10)
                                    }
                                }
                                Text(item)
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                            }
                            .foregroundColor(.black)
                        }
                    }
                    
                    HStack{
                        Spacer()
                         Button(action: {
                             withAnimation {
                                 self.show.toggle()
                             }
                         }) {
                             Text("CLOSE")
                                 .padding(.vertical, 10)
                                 .font(.system(size: 13, weight: .semibold, design: .rounded))
                                 .foregroundColor(.black.opacity(0.7))
                         }
                    }
                    
                }
                .padding(.horizontal,20)
            }
            .background(Color.white)
            .cornerRadius(5)
            .padding(.horizontal,40)
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
        }
        .padding(.bottom,(UIApplication.shared.currentUIWindow()?.safeAreaInsets.bottom)! + UIScreen.main.bounds.height/3)
        .foregroundColor(.black.opacity(0.7))
    }
}
struct RadioListPopup_Previews: PreviewProvider {

    static var previews: some View {
        RadioListPopup(title: "Adult", itemName: "Adult", maxNumber: .constant(5), selected: .constant(1), show: .constant(true)) {
            print("hello")
        }
    }
}
