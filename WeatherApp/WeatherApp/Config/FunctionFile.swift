//
//  FunctionFile.swift
//  WeatherApp
//
//  Created by Anaïs Puig on 28/09/2022.
//

import Foundation
import SwiftUI


func Getdate(time: Double) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let date = Date(timeIntervalSinceReferenceDate: time)
    return dateFormatter.string(from: date)
}

func CheckCurrentDate(time: Double) -> Bool {
    let date = NSDate(timeIntervalSince1970: time)
    return Calendar.current.isDateInToday(date as Date)
}


func RoudTemp(temp: String) -> String{
    return  "\(Int(Double(temp)?.rounded() ?? 0) )"
}

func Convert(temp: Double) -> Double {
    @AppStorage("system") var system: Int = 0
    let celsius = temp
    if system == 0 {
        return celsius
    } else {
        return celsius * 9 / 5 + 32
    }
}

func SignConvert() -> String {
    @AppStorage("system") var system: Int = 0
    if system == 0 {
        return "°C"
    } else {
        return "°F"
    }
}

func getTomorow(time: Double) -> Bool {
    let date = NSDate(timeIntervalSince1970: time)
    return Calendar.current.isDateInTomorrow(date as Date)
}
func getYersteday(time: Double) -> Bool {
    let date = NSDate(timeIntervalSince1970: time)
    return Calendar.current.isDateInYesterday(date as Date)
}
func getToday(time: Double) -> Bool {
    let date = NSDate(timeIntervalSince1970: time)
    return Calendar.current.isDateInToday(date as Date)
}
func windDirectionFromDegrees(degrees : Double) -> String {

    let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
    let i: Int = Int((degrees + 11.25)/22.5)
    return directions[i % 16]
}
func getReadableDate(timeStamp: Double) -> String? {
    let date = NSDate(timeIntervalSince1970:timeStamp)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    
    let currentDateString: String = dateFormatter.string(from: date as Date)
    let result : String = currentDateString
    
    let startIndex = result.index(result.startIndex, offsetBy: 3)
    return String(result[..<startIndex]).firstUppercased
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
