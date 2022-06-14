//
//  SignoutView.swift
//  flightexpert
//
//  Created by sohan on 6/14/22.
//

import SwiftUI

struct SignoutView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("Do you want to Logout?")
            
            
            Button(action: {
                self.signOut()
            }, label: {
                Text("Yes")
            })
        
        }
    }
    func signOut() {
        let defaults = UserDefaults.standard
        //Remove token from localStorage
        defaults.removeObject(forKey: "userEmail")
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "isSignin")
        isShowing = false
    }
}

struct SignoutView_Previews: PreviewProvider {
    static var previews: some View {
        SignoutView(isShowing: .constant(true))
    }
}
