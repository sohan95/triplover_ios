//
//  SideMenuView.swift
//  flightexpert
//
//  Created by sohan on 5/6/22.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient( colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            VStack {
                // Header
                SideMenuHeaderView(isShowing: $isShowing )
                    .frame(height: 200)
                // Cell Items
                ForEach(SideMenuViewModel.allCases, id: \.self) { option in
                    if option.title == "Home" {
                        NavigationLink(destination: HomeView(),
                            label: {
                                SideMenuOptionView(viewModel: option)
                            })
                    } else if option.title == "Login/Register" {
                        NavigationLink(destination:SigninView(),
                            label: {
                                SideMenuOptionView(viewModel: option)
                            })
                    } else if option.title == "Logout" {
                        NavigationLink(destination:LogoutView(isShowing: $isShowing),
                            label: {
                                SideMenuOptionView(viewModel: option)
                            })
                    }
                    else {
                        NavigationLink(destination:SigninView(),
                            label: {
                                SideMenuOptionView(viewModel: option)
                            })
                    }
                    
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}

struct LogoutView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("Do you want to Logout?")
            
            
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Yes")
            })
        
        }
    }
}

