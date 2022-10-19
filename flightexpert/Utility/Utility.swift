//
//  Utility.swift
//  flightexpert
//
//  Created by sohan on 6/28/22.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

let blueGradient = LinearGradient(
    colors: [Color(hex: "#474998"),Color(hex: "#2c99d5")],
    startPoint: .leading, endPoint: .trailing)

//let orangeGradient = LinearGradient(
//    colors: [Color(hex: "#F16B2E"),Color(hex: "#DDB756")],
//    startPoint: .leading, endPoint: .trailing)
let orangeGradient = LinearGradient(
    colors: [Color(hex: "#F16B2E"),Color(hex: "#DDB756")],
    startPoint: .leading, endPoint: .trailing)

let tabBarColor = Color(hex: "#6CB6F6")

// Background Image
let BackgroundImage = Image("home_background")
let SplashScreenBg = Image("splash_screen")
let ROOT_URL_THUMB = "https://tbbd-flight.s3.ap-southeast-1.amazonaws.com/airlines-logo/"

func getTimeString(dateStr: String) -> String {
//        let string = "2022-07-30 18:00:00"

    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = dateFormatter.date(from: dateStr)!
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.locale = tempLocale // reset the locale
    let dateString = dateFormatter.string(from: date)
//    print("EXACT_DATE : \(dateString)")
    return dateString
}

func getTimeStringWithTemplate(dateStr: String, template: String) -> String {
//        let string = "2022-07-30 18:00:00"

    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = template
    let date = dateFormatter.date(from: dateStr)!
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.locale = tempLocale // reset the locale
    let dateString = dateFormatter.string(from: date)
//    print("EXACT_DATE : \(dateString)")
    return dateString
}

func getDateStringWithTemplate(dateStr: String, template: String) -> String {
//        let string = "2022-07-30 18:00:00"

    if dateStr.isEmpty {
        return ""
    }
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = template
    let date = dateFormatter.date(from: dateStr)!
    dateFormatter.dateFormat = "MMM d, yyyy"
    dateFormatter.locale = tempLocale // reset the locale
    let dateString = dateFormatter.string(from: date)
//    print("EXACT_DATE : \(dateString)")
    return dateString
}

func getDateString(dateStr: String) -> String {
//        let string = "2022-07-30 18:00:00"

    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = dateFormatter.date(from: dateStr)!
    dateFormatter.dateFormat = "MMM d, yyyy"
    dateFormatter.locale = tempLocale // reset the locale
    let dateString = dateFormatter.string(from: date)
//    print("EXACT_DATE : \(dateString)")
    return dateString
}

//func getDateFromString(dateStr: String) -> Date {
//    let dateFormatter = DateFormatter()
//    // Set Date Format
//    dateFormatter.dateFormat = "h:mm a"
//    return dateFormatter.date(from: dateStr)!
//}

func getDateFromString(dateStr:String) -> Date {
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = dateFormatter.date(from: dateStr)!
    return date
}

func getDayNameOfWeek(todayDate:Date) -> String {
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    let weekDayName = EnumDays.init(rawValue: weekDay)
    //print("Day = \(String(describing: weekDay1))")
    guard let unwrapped = weekDayName else {
        return ""
    }
    return String(describing: unwrapped)
}

// Enum to output days
enum EnumDays : Int
{
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
}


