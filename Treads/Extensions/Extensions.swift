//
//  Extensions.swift
//  Treads
//
//  Created by Maksim Ponomarev on 11.11.2020.
//

import Foundation

extension Double {
    
    func metersToMiles(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        
        return ((self/1609.34) * divisor).rounded() / divisor
    }
}
