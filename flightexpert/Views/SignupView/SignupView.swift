//
//  SignupView.swift
//  flightexpert
//
//  Created by sohan on 5/16/22.
//

import SwiftUI

struct SignupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var fullName = ""
    @State var mobile = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var isPasswordSave = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Register")
                        .fontWeight(.medium)
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding()
                    
                    VStack {
                        CustomTextField(placeholder:Text("Full Name").foregroundColor(.black), text: $fullName)
                            .foregroundColor(Color.black)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .foregroundColor(Color.red)
                            .cornerRadius(10)
                        
                        CustomTextField(placeholder:Text("Mobile Number").foregroundColor(.black), text: $mobile)
                            .foregroundColor(Color.black)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(
                            .secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                        
                        
                        CustomTextField(placeholder:Text("Email").foregroundColor(.black), text: $email)
                            .foregroundColor(Color.black)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(
                            .secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                        
                        CustomSecureField(placeholder:Text("Password").foregroundColor(.black), text: $password)
                            .foregroundColor(Color.black)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(
                            .secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                        
                        CustomSecureField(placeholder:Text("Confirm Password").foregroundColor(.black), text: $confirmPassword)
                            .foregroundColor(Color.black)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(
                            .secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        self.registerAction()
                        
                    }, label: {
                        Text("Register")
                            .fontWeight(.medium)
                            .font(.title)
                            .foregroundColor(Color.white)
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 3))
                            
                    })
                    .background(Color.secondary)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .background(Color(red: 0.32, green:0.48, blue: 0.81))
            }
            .cornerRadius(10)
            .padding()
            
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func registerAction() {
        guard !fullName.isEmpty, !mobile.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            return
        }
        
        let registerRequest: RegisterRequest = RegisterRequest(fullName: fullName, mobile: mobile, email: email, password: password, confirmPassword: confirmPassword)
        
        HttpUtility.shared.registerService(registerRequest: registerRequest) { result in
            DispatchQueue.main.async {
                guard let temp = result else {
                    return
                }
                
                if temp.isSuccess == true {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    print("doesn't contain value")
                }
                
            }
        }
        //viewModel.signUp(firstName: firstName, lastName: lastName, email: email, password: password, reEnterPassword: reEnterpassword)
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



struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
