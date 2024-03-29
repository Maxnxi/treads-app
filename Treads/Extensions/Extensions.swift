//
//  Extensions.swift
//  Treads
//
//  Created by Maksim Ponomarev on 11.11.2020.
//

import Foundation
import UIKit

extension Double {
    
    func metersToMiles(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        //let divisorTen = pow(10.0, <#T##Double#>)
        
        return ((self/1609.34) * divisor).rounded() / divisor
    }
    
    func metersToKilometers(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self/1000.00 * divisor).rounded() / divisor
    }
}

extension Int {
    
    func formatTimeDurationToString() -> String {
        let durationsHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = ((self % 3600) % 60)
        if durationSeconds < 0 {
            return "00:00:00"
        } else {
            if durationsHours == 0 {
                return String(format: "%02d:%02d", durationMinutes, durationSeconds)
            } else {
                return String(format: "%02d:%02d:%02d", durationsHours, durationMinutes, durationSeconds)
            }
        }
    }
}

extension NSDate {
    func getDateString() -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self as Date)
        let day = calendar.component(.day, from: self as Date)
            let year = calendar.component(.year, from: self as Date)
        return "\(month)/\(day)/\(year)"
    }
}

extension UIButton {
    
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func setDeSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
    }
    
}
