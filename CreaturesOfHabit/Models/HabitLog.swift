//
//  HabitLog.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-13.
//

import Foundation
import SwiftData

@Model
class HabitLog {
    var id: UUID = UUID()
    var unitsTotal: Double
    var unitsCompleted: Double
    var isComplete: Bool
    var date: Date
    var exp: Double
    @Relationship var user: User
    @Relationship var habit: Habit
    
    init(id: UUID, unitsTotal: Double, unitsCompleted: Double = 0.0, isComplete: Bool = false, date: Date = Date(), user: User, habit: Habit) {
        self.id = id
        self.unitsTotal = unitsTotal
        self.unitsCompleted = unitsCompleted
        self.isComplete = isComplete
        self.date = date
        self.user = user
        self.habit = habit
        self.exp = Utils.randomExp(unitsLower: habit.unitsLower, unitsUpper: habit.unitsUpper)
    }
    
    func incrementUnitsCompleted() -> Bool {
        unitsCompleted += 1
        let isComplete = checkCompletion()
        return isComplete
    }
    
    private func checkCompletion() -> Bool {
        if unitsCompleted >= unitsTotal {
            unitsCompleted = unitsTotal // Prevent exceeding total?
            isComplete = true
            print("Habit completed!")
        }
        return isComplete
    }
    
    func isSameDateAsToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, inSameDayAs: Date())
    }
}

let mockHabitLogs = mockHabits.map { habit in
    HabitLog(id: UUID(), unitsTotal: habit.units, unitsCompleted: 0, isComplete: false, date: Date(), user: mockUser, habit: habit)
}
