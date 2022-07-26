//
//  CustomPickerTextView.swift
//  Custom Picker
//
//  Created by Stewart Lynch on 2020-08-19.
//

import SwiftUI

struct CustomPickerTextView: View {
    @Binding var presentPicker: Bool
    @Binding var fieldString: String
    var placeholder: String
    @Binding var tag: Int
    var selectedTag: Int
    var body: some View {
        HStack {
            TextField(placeholder, text: $fieldString)
//                .padding([.horizontal], 10)
//                .frame(height: 35)
//                .textFieldStyle(PlainTextFieldStyle())
//                .cornerRadius(5)
//                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
            
    //            .padding(7)
    //            .background(Color.gray.opacity(0.3).cornerRadius(5))
    //            .disabled(true)
                .overlay(
                    Button(action: {
                        tag = selectedTag
                        withAnimation {
                            presentPicker = true
                        }
                    }) {
                        Rectangle().foregroundColor((Color.clear))
                    }
                )
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(Color.gray.opacity(0.5))
                .font(Font.system(size: 15, weight: .bold))
        }
        .padding([.horizontal], 10)
        .frame(height: 35)
        .textFieldStyle(PlainTextFieldStyle())
        .cornerRadius(5)
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
    }
}

struct CustomPickerTextView_Previews: PreviewProvider {
    static var previews: some View {
        //CustomPickerTextView(value: .constant("ABCD"))
        CustomPickerTextView(presentPicker: .constant(true), fieldString: .constant("Passport"), placeholder: "Passport", tag: .constant(5), selectedTag: 5)
    }
}
