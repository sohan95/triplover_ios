//
//  HomeView.swift
//  flightexpert
//
//  Created by sohan on 5/10/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var showsAlert = false
    @State var selectedMenu: String = String()
    @State var selectedTab: String = String()
    let btnImgWidth: Double = 90.0
    let btnImgWidth2: Double = 20.0
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    NavigationLink {
                        FlightView()
                    } label: {
                        Image("menu_flights")
                            .resizable()
                            .scaledToFit()
                            .frame(width: btnImgWidth)
                    }
                    
                    Button {
                        self.selectedMenu = "Hotels"
                        self.showsAlert.toggle()
                    } label: {
                        Image("menu_hotels")
                            .resizable()
                            .scaledToFit()
                            .frame(width: btnImgWidth)
                    }
                    Button {
                        self.selectedMenu = "Tour"
                        self.showsAlert.toggle()
                    } label: {
                        Image("menu_tour")
                            .resizable()
                            .scaledToFit()
                            .frame(width: btnImgWidth)
                    }
                    Button {
                        self.selectedMenu = "Visa"
                        self.showsAlert.toggle()
                    } label: {
                        Image("menu_visa")
                            .resizable()
                            .scaledToFit()
                            .frame(width: btnImgWidth)
                    }
                }
                .alert(isPresented: self.$showsAlert) {
                    Alert(title: Text(selectedMenu), message: Text("This feature is comming soon..."), dismissButton: .default(Text("THANKS")))
                }
                
                Image("image_1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(10)
                Image("image_2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(10)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 70) {
                    Button {
                        self.selectedTab = "Home"
//                        self.showsAlert.toggle()
//                        ContentView()
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
                    
                    NavigationLink {
                        MyBooking()
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
            .padding(.top, 120)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



