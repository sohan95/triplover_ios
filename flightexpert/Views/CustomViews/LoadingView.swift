//
//  LoadingView.swift
//  flightexpert
//
//  Created by sohan on 6/14/22.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//    let lightPurple = Color(red: 156/255, green: 16/255, blue: 179/255)
//    let darkPurple = Color(red: 11/255, green: 13/255, blue: 50/255)
//    let lightTeal = Color(red: 6/255, green: 243/255, blue: 232/255)
    
    var body: some View {
        ZStack {
            BackgroundImage
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
//            Color(.systemBackground)
//                .ignoresSafeArea()
//                .opacity(0.5)
//
//            ProgressView()
//                .progressViewStyle(CircularProgressViewStyle(tint: .red))
//                .scaleEffect(3)
            ProgressView()
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .scaleEffect(3)
            
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
