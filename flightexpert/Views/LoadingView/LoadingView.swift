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
    
    var body: some View {
        ZStack {
            SplashScreenBg
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
            
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
