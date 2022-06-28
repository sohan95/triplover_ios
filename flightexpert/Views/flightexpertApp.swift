//
//  flightexpertApp.swift
//  flightexpert
//
//  Created by sohan on 5/6/22.
//

import SwiftUI

@main
struct flightexpertApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
//            AirportList()
//            SigninView()
//            let viewModel = AppViewModel()
//            ContentView()
//                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
