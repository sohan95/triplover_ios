//
//  SideMenuHeaderView.swift
//  flightexpert
//
//  Created by sohan on 5/6/22.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Button(action: {
                withAnimation(.spring()) {
                    isShowing.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.black)
                    .padding()
            })
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    Image("profile_banner")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 180, height: 180)
                        .cornerRadius(5)
                        .shadow(color: Color.gray, radius: 10, x: 5, y: 5)
                        .padding(.bottom, 16)
                        
                    Spacer()
                }
                Spacer()
            }
            .padding()
            
    
            
//            VStack(alignment: .leading) {
//                Image("girl-icon")
//                    .resizable()
//                    .scaledToFill()
//                    .clipped()
//                    .frame(width: 64, height: 64)
//                    .clipShape(Circle())
//                    .padding(.bottom, 16)
//
//
//                Spacer()
//
//            }
//            .foregroundColor(.white)
//        .padding()
        }
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
