//
//  Habit.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-13.
//

import Foundation
import SwiftData

@Model
class Habit {
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

let mockHabits = [
    Habit(name: "Drink water", units: 2, unitsLower: 1, unitsUpper: 3, ExpRate: 5),
    Habit(name: "Brush teeth", units: 1, unitsLower: 1, unitsUpper: 2, ExpRate: 10),
    Habit(name: "Morning jog", units: 3, unitsLower: 1, unitsUpper: 5, ExpRate: 15),
    Habit(name: "Read a book", units: 10, unitsLower: 2, unitsUpper: 10, ExpRate: 8)
]
