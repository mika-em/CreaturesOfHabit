//
//  Goal.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-13.
//

import Foundation
import SwiftData

@Model
class Goal {
    var id: UUID = UUID()
    var name: String
    var units: Double
    var unitsLower: Double
    var unitsUpper: Double
    var ExpRate: Double
    
    init(name: String, units: Double, unitsLower: Double, unitsUpper: Double, ExpRate: Double) {
        self.name = name
        self.units = units
        self.unitsLower = unitsLower
        self.unitsUpper = unitsUpper
        self.ExpRate = ExpRate
    }
}
