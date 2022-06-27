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
    @State var userEmail: String = String()
    @State var userPassword: String = String()
    @Environment(\.presentationMode) var presentationMode
    
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
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
                                .foregroundColor(Color.black)
                            Text("Let's continue your journey")
                                .fontWeight(.medium)
                                .font(.system(size: 14,design: .rounded))
                                .foregroundColor(Color.black)
                        }
                        
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.black)
                                    .padding(15)
                                TextField("Email", text: $userEmail)
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
                            Text("Login")
                                .frame(maxWidth:.infinity)
                                .padding([.top, .bottom], 10)
                                .background(Color.secondary)
                                .foregroundColor(Color.white)
                                .cornerRadius(7.5) 
                        })
                        
    //                    .alert(isPresented: $isLoggedin, content: {
    //                        Alert(title: Text("Login Success"), message: Text("Right now you can book any fligh!"), dismissButton: .cancel(Text("Ok")))
    //                    })
                        Text("Forgot Password")
                            .padding()
                        HStack {
                            Text("Don't have an account?")
                            NavigationLink {
                                SignupView()
                            } label: {
                                Text("Create New")
                                    .underline()
                                    .font(.system(size: 14, weight:.bold))
                            }
                        }
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
    //                    .padding([.top,.bottom])
                    }
                    .padding(30)
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
    
    func loginAction() {
        let deviceId = UUID().uuidString
        let loginRequest = LoginRequest(email: userEmail, password: userPassword, deviceId: deviceId)
        
        HttpUtility.shared.loginService(loginRequest: loginRequest) { result in
            DispatchQueue.main.async {
                //Save token in localStorage
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
