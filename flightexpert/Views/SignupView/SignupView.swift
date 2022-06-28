//
//  SignupView.swift
//  flightexpert
//
//  Created by sohan on 5/16/22.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var fullName = ""
    @State var mobile = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var isPasswordSave = false
    
    @State private var checked = true
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image(systemName: "arrow.backward") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
            }
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                VStack {
                    VStack(spacing:10) {
                        Text("Create Account!")
                            .fontWeight(.medium)
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .foregroundColor(Color.black)
                        Text("Let's continue your journey")
                            .fontWeight(.medium)
                            .font(.system(size: 14,design: .rounded))
                            .foregroundColor(Color.black)
                    }
                    
                    VStack(spacing:10) {
                            
                        SignupTextField(placeholder:"Name", text: $fullName)
                        SignupTextField(placeholder:"Email", text: $email)
                        SecureInputView("Password", text: $password)
                        SecureInputView("Re-Enter Password", text: $confirmPassword)
                        SignupTextField(placeholder:"Phone Number", text: $mobile)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Image("bullet-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width:10)
                            Text("Password must be 8 chareacters")
                                .font(.system(size: 13))
                        }
                        HStack {
                            Image("bullet-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width:10)
                            Text("Password must have 1 upper case(AB) & lower case latter (ab)")
                                .font(.system(size: 13))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                        }
                        HStack {
                            Image("bullet-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width:10)
                            Text("Password must have one number")
                                .font(.system(size: 13))
                        }
                        HStack {
                            CheckBoxView(checked: $checked)
                            VStack(alignment: .leading, spacing: 2){
                                Text("Element that requires checkmark!")
                                NavigationLink {
                                    SigninView()
                                } label: {
                                    Text("Terms & Conditions")
                                        .underline()
                                        .font(.system(size: 14, weight:.bold))
                                }
                                
                            }
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                            
                        }
                        
                    }
                    .padding(.horizontal, 30)
                    
                    Button(action: {
                        self.registerAction()
                    }, label: {
                        Text("Create Account")
                            .frame(maxWidth:.infinity)
                            .padding([.top, .bottom], 10)
                            .background(blueGradient)
                            .foregroundColor(Color.white)
                            .cornerRadius(7.5)
                    })
                    .padding(.horizontal, 30)
                    
                    HStack {
                        Text("Already have an account?")
                        NavigationLink {
                            SigninView()
                        } label: {
                            Text("Login")
                                .underline()
                                .font(.system(size: 14, weight:.bold))
                        }
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                }
                .frame(minHeight: 600, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3)
                    )
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 100)
                )
                
                Image("app_name_header")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(.bottom, 64)
                    .padding(.top, 20)
            }
        }
        .navigationTitle("Login/Register")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
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

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.black) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
