//
//  SigninView.swift
//  flightexpert
//
//  Created by sohan on 5/16/22.
//

import SwiftUI

struct SigninView: View {
    @State var isLoggedin: Bool = false
    @State var userEmail: String = String()
    @State var userPassword: String = String()
    @Environment(\.presentationMode) var presentationMode
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Login")
                        .fontWeight(.medium)
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding()
                    
                    VStack(spacing: 15) {
                        CustomTextField(placeholder:Text("Email").foregroundColor(.black), text: $userEmail)
                            .foregroundColor(Color.black)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                        
                        CustomSecureField(placeholder:Text("Password").foregroundColor(.black), text: $userPassword)
                            .foregroundColor(Color.black)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        self.loginAction()
                    }, label: {
                        Text("Login")
                            .foregroundColor(Color.white)
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 30)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.white, lineWidth: 3))
                            
                    })
                    .background(Color.secondary)
                    .cornerRadius(10)
                    .padding([.top,.bottom])
//                    .alert(isPresented: $isLoggedin, content: {
//                        Alert(title: Text("Login Success"), message: Text("Right now you can book any fligh!"), dismissButton: .cancel(Text("Ok")))
//                    })
                    
                    HStack {
                        NavigationLink("Forgot Password?", destination: SignupView())
                        NavigationLink("New User Signup Here ", destination: SignupView())
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
//                    .padding([.top,.bottom])
                }
                .padding()
                .background(Color(red: 0.32, green:0.48, blue: 0.81))
                .cornerRadius(15)
                
                Spacer()
            }

//            .buttonBorderShape(.roundedRectangle(radius: 10))
//            .padding()
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func loginAction() {
        let deviceId = UUID().uuidString
        let loginRequest = LoginRequest(email: userEmail, password: userPassword, deviceId: deviceId)
        
        HttpUtility.shared.loginService(loginRequest: loginRequest) { result in
            DispatchQueue.main.async {
                //Save token in localStorage
                defaults.set(userEmail, forKey: "userEmail")
                defaults.set(result?.token, forKey:"token")
                isLoggedin = true
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
            
    }
}
