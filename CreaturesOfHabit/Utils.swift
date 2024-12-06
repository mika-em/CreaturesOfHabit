//
//  Utils.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-03.
//

import Foundation
import SwiftUI

enum Utils {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    static func randomExp(unitsLower: Double, unitsUpper: Double) -> Double {
        print("unitsLower: \(unitsLower), unitsUpper: \(unitsUpper)\n")
        let randomValue = Double.random(in: unitsLower...unitsUpper)
        print("randomValue: \(randomValue)")

        let exp = (randomValue / 5).rounded(.up) * 5
        
        return exp
    }
}
