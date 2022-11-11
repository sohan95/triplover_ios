//
//  HomeView.swift
//  flightexpert
//
//  Created by sohan on 5/10/22.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    @State var showsAlert = false
    @State var selectedMenu: String = String()
    @State var selectedTab: String = String()
    //@State private var selection: String? = nil
    let btnImgWidth2: Double = 20.0
    @State var bottomPadding: CGFloat = 50.0
    
    var body: some View {
        ZStack {
            BackgroundImage
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                //Top Menus
                HStack(alignment: .center) {
                    NavigationLink {
                        FlightSearchView()
                    } label: {
                        Image("menu_flights")
                            .resizable()
                            .scaledToFit()
                    }

                    Button {
                        withAnimation {
                            self.selectedMenu = "Hotels"
                            self.showsAlert.toggle()
                        }
                    } label: {
                        Image("menu_hotels")
                            .resizable()
                            .scaledToFit()
                    }

                    Button {
                        withAnimation {
                            self.selectedMenu = "Tour"
                            self.showsAlert.toggle()
                        }
                    } label: {
                        Image("menu_tour")
                            .resizable()
                            .scaledToFit()
                    }

                    Button {
                        withAnimation {
                            self.selectedMenu = "Visa"
                            self.showsAlert.toggle()
                        }
                    } label: {
                        Image("menu_visa")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .padding(.horizontal,10)
                .alert(isPresented: self.$showsAlert) {
                    Alert(title: Text(selectedMenu), message: Text("This feature is comming soon..."), dismissButton: .default(Text("THANKS")))
                }
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                
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
                HStack(alignment: .center, spacing: 70) {
                    Button {
                        self.selectedTab = "Home"
    //                        self.showsAlert.toggle()
    //                        ContentView()
                    } label: {
                        VStack{
                            if (self.selectedTab == "Home"){
                                Image(systemName:"house.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: btnImgWidth2)
                                Text("Home")
                                    .padding(.top, -2)
                                    .font(.system(size: 11, weight: .bold, design: .rounded))
                            } else {
                                Image(systemName:"house")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: btnImgWidth2)
                                Text("Home")
                                    .padding(.top, -2)
                            }
                            
                                
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
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color("colorPrimary"))
                .accentColor(.white)
            }
            .padding(.top, bottomPadding)
            .padding(.bottom, bottomPadding)
        }
        .onAppear(perform: {
            //check Device Notch
            if UIDevice.current.hasNotch {
                //... consider notch
                bottomPadding = 44.0
            } else {
                bottomPadding = 100.0
            }
            getUIDecorationData()
        })
        .environmentObject(flightSearchModel)
    }
    
    func getUIDecorationData(){
        HttpUtility.shared.getUIDecorationData(completionHandler: { result in
            DispatchQueue.main.async { [self] in
                //self.isLoading = false
                
                guard let result = result else {
                    //self.showErrorAlert.toggle()
                    return
                }
                flightSearchModel.decorationData = result
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



