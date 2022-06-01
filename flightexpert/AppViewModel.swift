//
//  AppViewModel.swift
//  flightexpert
//
//  Created by sohan on 5/16/22.
//

import SwiftUI

class AppViewModel: ObservableObject {
    
    @Published var signedIn = false;
    
    var isSignendIn: Bool {
        return true;
    }
    
    func signIn(email: String, password: String) {
        signedIn = true 
    }
    func signIn2(sign: Bool) {
        signedIn = sign
    }
    
    func signUp(firstName: String, lastName: String, email:String, password: String, reEnterPassword: String) {
        signedIn = false
    }
    
    func signOut() {
        signedIn = false;
    }
}
