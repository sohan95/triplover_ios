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
    @State var userEmail: String = "apptestuser@triplover.com" //String()
    @State var userPassword: String = "Asdf123@" // String()
    @Environment(\.presentationMode) var presentationMode
    
    @State var showErrorAlert = false
    @State var errorMsg = ""
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
        ZStack {
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
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
                        
    //                    .alert(isPresented: $isLoggedin, content: {
    //                        Alert(title: Text("Login Success"), message: Text("Right now you can book any fligh!"), dismissButton: .cancel(Text("Ok")))
    //                    })
//                        Text("Forgot Password")
//                            .padding()
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
    //                    .padding([.top,.bottom])
                    }
                    .padding(30)
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3)
                    )
                    .padding([.leading, .trailing], 10)
                    .padding(.top, 100)
                )
                
                Image("app_name_header")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .padding(.bottom, 64)
                    .padding(.top, 20)
            }
        }
        .navigationTitle("Login/Register")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: btnBack)
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Failed!"), message: Text(errorMsg), dismissButton: .default(Text("Close")))
        }
        
    }

    
    func loginAction() {
        
        let result = loginValidation.validateUserInputs(userEmail: userEmail, userPassword: userPassword)
        if(result.success == false){
            self.errorMsg = result.errorMessage ?? "error occured"
            self.showErrorAlert.toggle()
            return
        }
        
        let deviceId = UUID().uuidString
        let loginRequest = LoginRequest(email: userEmail, password: userPassword, deviceId: deviceId)
        
        HttpUtility.shared.loginService(loginRequest: loginRequest) { result in
            DispatchQueue.main.async {
                //Save token in localStorage
                guard result != nil else {
                    self.errorMsg = "Sorry, Login failed. Try again."
                    self.showErrorAlert.toggle()
                    return
                }
                defaults.set(userEmail, forKey: "userEmail")
                defaults.set(result?.token, forKey:"token")
                defaults.set(true, forKey: "isSignin")
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
