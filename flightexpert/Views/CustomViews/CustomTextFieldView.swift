//
//  CustomTextFieldView.swift
//  flightexpert
//
//  Created by sohan on 6/27/22.
//

import SwiftUI

struct CustomTextFieldView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct IconTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            //if text.isEmpty { placeholder }
            HStack {
                Image(systemName:"person")
                    .foregroundColor(.gray).padding(20)
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            }
            
        }
    }
}

struct SecureInputView: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.black)
            }
        }
        .font(.system(size: 11, weight: .regular, design: .rounded))
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(4)
    }
}

struct SignupTextField: View {
    var placeholder: String
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        TextField(placeholder, text: $text, onEditingChanged: editingChanged, onCommit: commit)
        .font(.system(size: 11, weight: .regular, design: .rounded))
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(4)
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
        
}

struct CustomSecureField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            SecureField("", text: $text, onCommit: commit)
        }
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
//        IconTextField(placeholder:Text("Email"),text: .constant("Shahanur Rahman"))
//        CustomTextFieldView()
        SecureInputView("Password", text: .constant("Shahanur Rahman"))
    }
}
