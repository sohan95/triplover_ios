//
//  SideMenuViewModel.swift
//  flightexpert
//
//  Created by sohan on 5/6/22.
//

import Foundation
import IOSurface

enum SideMenuViewModel: Int, CaseIterable {
    case home
    case login
    case myBooking
    case aboutUs
    case contactUs
    case logout
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .login: return "Login/Register"
        case .myBooking: return "My Booking"
        case .aboutUs: return "About Us"
        case .contactUs: return "Contact Us"
        case .logout: return "Logout"
        
        }
    }
    var imageName: String {
        switch self {
        case .home: return "house.fill"
        case .login: return "arrow.turn.up.forward.iphone"
        case .myBooking: return "airplane"
        case .aboutUs: return "info.circle.fill"
        case .contactUs: return "phone.fill"
        case .logout: return "arrow.left.square"
        }
    }
    
}
