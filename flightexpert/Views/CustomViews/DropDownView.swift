//
//  DropDownView.swift
//  flightexpert
//
//  Created by sohan on 6/12/22.
//

import SwiftUI

struct DropDownView: View {
    @Binding var value: String
    var placeholder = "Select title"
    var dropDownList = ["MR", "MRS"]
    
//    typealias Action = (String) -> Void
//    var action: Action?
    
    var body: some View {
        Menu {
            ForEach(dropDownList, id: \.self){ client in
                Button(client) {
                    self.value = client
                }
            }
        } label: {
            VStack(spacing: 5){
                HStack{
                    Text(value.isEmpty ? placeholder : value)
                        .foregroundColor(value.isEmpty ? .gray : .black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.gray.opacity(0.5))
                        .font(Font.system(size: 15, weight: .bold))
                }
//                .padding(7)
//                .background(Color.gray.opacity(0.3).cornerRadius(5))
//                .padding(.horizontal)
//                Rectangle()
//                    .fill(Color.orange)
//                    .frame(height: 2)
                
                .padding([.horizontal], 10)
                .frame(height: 35)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
            }
        }
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(value: .constant("ABCD"))
    }
}
