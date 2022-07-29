//
//  HomeView.swift
//  flightexpert
//
//  Created by sohan on 5/10/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    @State var showsAlert = false
    @State var selectedMenu: String = String()
    @State var selectedTab: String = String()
    //@State private var selection: String? = nil
    let btnImgWidth: Double = 80.0
    let btnImgWidth2: Double = 20.0
    
    var body: some View {
//        ZStack {
//            //Color.gray
//            //NavigationLink(destination:MyBooking(), tag: "MyBooking", selection: $selection) { EmptyView() }
//
//            VStack(alignment: .center, spacing: 0) {
//                HStack(alignment: .center) {
//                    NavigationLink {
//                        FlightView()
//                    } label: {
//                        Image("menu_flights")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: btnImgWidth)
//                    }
//                    .frame(width: 80, height: 80, alignment: .center)
//
//
//                    Button {
//                        self.selectedMenu = "Hotels"
//                        self.showsAlert.toggle()
//                    } label: {
//                        Image("menu_hotels")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: btnImgWidth)
//                    }.frame(width: 80, height: 80, alignment: .center)
//                    Button {
//                        self.selectedMenu = "Tour"
//                        self.showsAlert.toggle()
//                    } label: {
//                        Image("menu_tour")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: btnImgWidth)
//                    }.frame(width: 80, height: 80, alignment: .center)
//                    Button {
//                        self.selectedMenu = "Visa"
//                        self.showsAlert.toggle()
//                    } label: {
//                        Image("menu_visa")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: btnImgWidth)
//                    }.frame(width: 80, height: 80, alignment: .center)
//                }
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .alert(isPresented: self.$showsAlert) {
//                    Alert(title: Text(selectedMenu), message: Text("This feature is comming soon..."), dismissButton: .default(Text("THANKS")))
//                }
//
//                Image("image_1")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: .infinity)
//                    .padding(10)
//                Image("image_2")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: .infinity)
//                    .padding(10)
//
//                Spacer()
//
//                HStack(alignment: .center, spacing: 70) {
//                    Button {
//                        self.selectedTab = "Home"
////                        self.showsAlert.toggle()
////                        ContentView()
//                    } label: {
//                        VStack{
//                            Image(systemName: "house")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: btnImgWidth2)
//                            Text("Home")
//                                .padding(.top, -5)
//                                .font(.system(size: 12, weight: .bold))
//                        }
//                    }
//
//                    NavigationLink {
//                        MyBooking()
//                    } label: {
//                        VStack{
//                            Image(systemName: "paperplane")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: btnImgWidth2)
//                            Text("My Booking")
//                                .padding(.top, -5)
//                                .font(.system(size: 12, weight: .bold))
//                        }
//                    }
//
//                    NavigationLink {
//                        SigninView()
//                    } label: {
//                        VStack{
//                            Image(systemName: "rectangle.portrait.and.arrow.right")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: btnImgWidth2)
//                            Text("Login")
//                                .padding(.top, -5)
//                                .font(.system(size: 12, weight: .bold))
//                        }
//
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: 60)
//                .background(Color("colorPrimary"))
//                .accentColor(.white)
//                .padding(.bottom, 64)
//            }
//            .padding(.top, 120)
//            //.padding(10)
//        }
        VStack(alignment: .center, spacing: 0) {
            //Top Menus
            HStack(alignment: .center) {
                NavigationLink {
                    FlightView()
                } label: {
                    Image("menu_flights")
                        .resizable()
                        .scaledToFit()
                        .frame(width: btnImgWidth)
                }
                .frame(width: 70, height: 70, alignment: .center)
                
                
                Button {
                    self.selectedMenu = "Hotels"
                    self.showsAlert.toggle()
                } label: {
                    Image("menu_hotels")
                        .resizable()
                        .scaledToFit()
                        .frame(width: btnImgWidth)
                }.frame(width: 70, height: 70, alignment: .center)
                
                Button {
                    self.selectedMenu = "Tour"
                    self.showsAlert.toggle()
                } label: {
                    Image("menu_tour")
                        .resizable()
                        .scaledToFit()
                        .frame(width: btnImgWidth)
                }.frame(width: 70, height: 70, alignment: .center)
                
                Button {
                    self.selectedMenu = "Visa"
                    self.showsAlert.toggle()
                } label: {
                    Image("menu_visa")
                        .resizable()
                        .scaledToFit()
                        .frame(width: btnImgWidth)
                }.frame(width: 70, height: 70, alignment: .center)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.horizontal,10)
            .alert(isPresented: self.$showsAlert) {
                Alert(title: Text(selectedMenu), message: Text("This feature is comming soon..."), dismissButton: .default(Text("THANKS")))
            }
            
            Spacer()
            VStack{
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
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Spacer()
            // Bottom Menus
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
                            .padding(.top, -2)
                            
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
                            .padding(.top, -2)
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
                            .padding(.top, -2)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .font(.system(size: 10, weight: .medium, design: .rounded))
            .background(Color("colorPrimary"))
            .accentColor(.white)
            .padding(.bottom, 44)
        }
        .padding(.top, 100)
        .environmentObject(flightSearchModel)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



