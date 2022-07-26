//
//  RadioButtonsPopup.swift
//  flightexpert
//
//  Created by sohan on 7/22/22.
//

import SwiftUI

//struct RadioButtonsPopup: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
struct RadioButtonsPopup : View {
    @Binding var selected : String
    @Binding var show : Bool
    
    var doneAction : () -> ()
    
    var body : some View{
        
        VStack{
            VStack{
                VStack(alignment: .leading, spacing: 20) {
                    Text("Filter By")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.black.opacity(0.7))
                        .padding(.top)
                    
                    ForEach(sortCategoryList,id: \.self){item in
                        
                        Button(action: {
                            self.selected = item
                            self.doneAction()
                        }) {
                            HStack(alignment:.center, spacing: 20) {
                                ZStack(alignment: .center){
                                    Circle().stroke(self.selected == item ? Color.black : Color.gray, lineWidth: 2).frame(width: 20, height: 20)
                                    
                                    if self.selected == item {
                                        Circle().fill(Color.black).frame(width: 15, height: 15)
                                    }
                                }
                                Text(item)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                
                            }
                            .foregroundColor(.black)
                        }
                    }
                    
                    HStack{
                        Spacer()
                         Button(action: {
                            self.show.toggle()
                         }) {
                             Text("CLOSE")
                                 .padding(.vertical, 10)
                                 .font(.system(size: 16, weight: .bold, design: .rounded))
                                 .foregroundColor(.black.opacity(0.8))
                         }
                    }
                    
                }
                .padding(.horizontal,30)
            }
            .background(Color.white)
            .cornerRadius(5)
            .padding(.horizontal,30)
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
        }
        .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + UIScreen.main.bounds.height/3)
        .foregroundColor(.black.opacity(0.8))
    }
}

struct RadioButtonsPopup_Previews: PreviewProvider {
    static var previews: some View {
        
        RadioButtonsPopup(selected: .constant(""), show: .constant(true)) {
              print("hello")
          }
    }
}
