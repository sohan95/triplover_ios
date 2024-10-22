//
//  SigninView.swift
//  flightexpert
//
//  Created by sohan on 5/16/22.
//

import SwiftUI

struct SigninView: View {
    var from: String = String()
    @State var isLoggedin: Bool = false
    @State var userEmail: String = "akash71khan@gmail.com" //String()
    @State var userPassword: String = "123456" // String()
    @Environment(\.presentationMode) var presentationMode
    
    @State var isShowAlert = false
    @State var alertMsg = ""
    @State var alertTitle = "Failed!"
    private let loginValidation = LoginValidation()
    
    let defaults = UserDefaults.standard
    
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
        ScrollView {
            VStack(spacing: 10) {
                VStack(spacing: 30) {
                    VStack(spacing: 30) {
                        VStack {
                            Text("Welcome!")
                                .fontWeight(.medium)
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .foregroundColor(Color.black)
                            Text("Let's continue your journey")
                                .fontWeight(.medium)
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundColor(Color.black)
                        }
                        
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.black)
                                    .padding(15)
                                TextField("Email", text: $userEmail)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 13, weight: .regular, design: .rounded))
                            }
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color(.secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(7.5)
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.black)
                                    .padding(15)
                                SecureField("Password", text: $userPassword)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 13, weight: .regular, design: .rounded))
                            }
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color(.secondarySystemBackground))
                            .foregroundColor(Color.black)
                            .cornerRadius(7.5)
                        }
                        
                        Button(action: {
                            self.loginAction()
                        }, label: {
                            Text("LOG IN")
                                .frame(maxWidth:.infinity)
                                .padding([.top, .bottom], 10)
                                .background(blueGradient)
                                .foregroundColor(Color.white)
                                .cornerRadius(7.5)
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                        })
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                            NavigationLink {
                                SignupView()
                            } label: {
                                Text("Create New")
                                    .underline()
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                            }
                        }
                        .foregroundColor(.black)
                    }
                    .padding(30)
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .padding([.leading, .trailing], 10)
                )
                .padding(.top, 80)
                
                Image("app_name_header")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .padding(.bottom, 64)
                    .padding(.top, 20)
            }
        }
        .background(
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .navigationTitle("Login/Register")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isShowAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .cancel(Text("OK")))
        })
    }

    
    func loginAction() {
        
        let result = loginValidation.validateUserInputs(userEmail: userEmail, userPassword: userPassword)
        if(result.success == false){
            self.alertMsg = result.errorMessage ?? "error occured"
            self.isShowAlert.toggle()
            return
        }
        
        let deviceId = UUID().uuidString
        let loginRequest = LoginRequest(email: userEmail, password: userPassword, deviceId: deviceId)
        
        HttpUtility.shared.loginService(loginRequest: loginRequest) { result in
            DispatchQueue.main.async {
                //Save token in localStorage
                guard result != nil else {
                    self.alertMsg = "Sorry, Login failed. Try again."
                    self.isShowAlert.toggle()
                    return
                }
                defaults.set(userEmail, forKey: "userEmail")
                defaults.set(result?.token, forKey:"token")
                defaults.set(true, forKey: "isSignin")
                
                self.alertTitle = "Login Success"
                self.alertMsg = "Right now you can book any fligh!"
                self.isShowAlert.toggle()
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
