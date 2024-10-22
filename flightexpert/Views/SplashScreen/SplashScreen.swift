//
//  SplashScreen.swift
//  flightexpert
//
//  Created by sohan on 6/24/22.
//

import SwiftUI
struct FakeProgressBar: View {
    var isActive: Bool
    @State var progressValue: Double = 0.0
    private let maxValue: Double = 50
    private let backgroundEnabled: Bool = true
    private let backgroundColor: Color = Color(UIColor(red: 245/255,
                                                       green: 245/255,
                                                       blue: 245/255,
                                                       alpha: 1.0))
    private let foregroundColor: Color = Color.orange
    
    let loaderTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            GeometryReader { geometryReader in
                if self.backgroundEnabled {
                    Capsule()
                        .foregroundColor(self.backgroundColor)
                }
                
                Capsule()
                    .frame(width: self.progress(value: self.progressValue,
                                                maxValue: self.maxValue,
                                                width: geometryReader.size.width),
                           height: 3.0)
                    .foregroundColor(self.foregroundColor)
                    .animation(.easeIn)
            }
            .onReceive(loaderTimer) { _ in
                if progressValue <= self.maxValue {
                    progressValue += 1.0
                } else if progressValue > self.maxValue {
                    self.loaderTimer.upstream.connect().cancel()
                    //self.isActive = true
                }
            }
        }
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

struct ProgressBar: View {
    @Binding var isActive: Bool
    @State var progressValue: Double = 0.0
    private let maxValue: Double = 20
    private let backgroundEnabled: Bool = true
    private let backgroundColor: Color = Color(UIColor(red: 245/255,
                                                       green: 245/255,
                                                       blue: 245/255,
                                                       alpha: 1.0))
    private let foregroundColor: Color = Color.orange
    
    let loaderTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            GeometryReader { geometryReader in
                if self.backgroundEnabled {
                    Capsule()
                        .foregroundColor(self.backgroundColor)
                }
                
                Capsule()
                    .frame(width: self.progress(value: self.progressValue,
                                                maxValue: self.maxValue,
                                                width: geometryReader.size.width),
                           height: 3.0)
                    .foregroundColor(self.foregroundColor)
                    .animation(.easeIn)
            }
            .onReceive(loaderTimer) { _ in
                if progressValue <= self.maxValue {
                    progressValue += 1.0
                } else if progressValue > self.maxValue {
                    self.loaderTimer.upstream.connect().cancel()
                    self.isActive = true
                }
            }
        }
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

struct SplashScreen: View {
    @State var isActive : Bool = false
//    @State private var sliderValue: Double = 0
//    private let maxValue: Double = 20
    @State var progressValue: Double = 0.0
    private let maxValue: Double = 20
    let loaderTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        if isActive {
            let flightSearchModel = FlightSearchModel()
            ContentView()
                .environmentObject(flightSearchModel)
        } else {
            ZStack {
                SplashScreenBg
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(2)
            }
            .onReceive(loaderTimer) { _ in
                if progressValue <= self.maxValue {
                    progressValue += 1.0
                } else if progressValue > self.maxValue {
                    self.loaderTimer.upstream.connect().cancel()
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
