//
//  ContentView.swift
//  flightexpert
//
//  Created by sohan on 5/6/22.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color(red: 128/255, green: 173/255, blue: 214/255), Color(red: 254/255, green: 253/255, blue: 253/255),Color(red: 249/255, green: 228/255, blue: 209/255)],
    startPoint: .top, endPoint: .bottom)

struct ContentView: View {
    
    @EnvironmentObject var flightSearchModel: FlightSearchModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                HomeView()
                    
            }
            .environmentObject(flightSearchModel)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
