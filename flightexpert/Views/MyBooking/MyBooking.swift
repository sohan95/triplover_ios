//
//  MyBooking.swift
//  flightexpert
//
//  Created by sohan on 6/28/22.
//

import SwiftUI

struct MyBooking: View {
    let btnImgWidth2: Double = 20.0
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("No Data Found")
                Spacer()
                HStack(alignment: .center, spacing: 70) {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        VStack{
                            Image(systemName: "house")
                                .resizable()
                                .scaledToFit()
                                .frame(width: btnImgWidth2)
                            Text("Home")
                                .padding(.top, -5)
                                .font(.system(size: 12, weight: .bold))
                        }
                    }
                    
                    Button {
                    } label: {
                        VStack{
                            Image(systemName: "paperplane")
                                .resizable()
                                .scaledToFit()
                                .frame(width: btnImgWidth2)
                            Text("My Booking")
                                .padding(.top, -5)
                                .font(.system(size: 12, weight: .bold))
                        }
                    }
                    
                    NavigationLink {
                        SigninView()
                    } label: {
                        VStack{
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: btnImgWidth2)
                            Text("Login")
                                .padding(.top, -5)
                                .font(.system(size: 12, weight: .bold))
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(.blue)
                .accentColor(.white)
                .padding(.bottom, 64)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct MyBooking_Previews: PreviewProvider {
    static var previews: some View {
        MyBooking()
    }
}
