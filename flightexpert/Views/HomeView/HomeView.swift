//
//  HomeView.swift
//  flightexpert
//
//  Created by sohan on 5/10/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Image("triplover-bg-image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HomeButtonView(title: "Flight",iconName: "airplane")
                    .padding([.leading, .trailing], 20)
                HomeButtonView(title: "Hotel",iconName: "building.2")
                    .padding([.leading, .trailing], 20)
                HomeButtonView(title: "Tour",iconName: "globe.americas")
                    .padding([.leading, .trailing], 20)
                HomeButtonView(title: "Login",iconName: "lock.fill")
                    .padding([.leading, .trailing], 20)
                
            }.padding()
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeButtonView: View {
    let title: String
    let iconName: String
    
    var body: some View {
        NavigationLink {
            if title == "Flight" {
                FlightView()
            }
            if title == "Login" {
                SigninView()
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: iconName)
                    .frame(width: 24, height: 24)
                    .padding(.leading, 5)
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                Spacer()
                Image(systemName: "arrow.right")
                    .frame(width: 24, height: 24)

            }
        }.padding()
            .foregroundColor(.black)
            .background(Color.gray)
            .cornerRadius(5)


//        Button(action: {
//
//            if title == "Login" {
//                SigninView()
//            }
//        }) {
//            HStack(spacing: 10) {
//                Image(systemName: iconName)
//                    .frame(width: 24, height: 24)
//                    .padding(.leading, 5)
//                Text(title)
//                    .font(.system(size: 15, weight: .semibold))
//                Spacer()
//                Image(systemName: "arrow.right")
//                    .frame(width: 24, height: 24)
//
//            }
//        }
//        .padding()
//        .foregroundColor(.black)
//        .background(Color.gray)
//        .cornerRadius(5)
    }
}
