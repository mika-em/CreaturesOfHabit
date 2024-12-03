//
//  GoalLog.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-13.
//

import Foundation
import SwiftData

@Model
class GoalLog {
    var id: UUID = UUID()
    var unitsTotal: Double
    var unitsCompleted: Double
    var isComplete: Bool
    @Relationship var user: User
    @Relationship var goal: Goal
    
    init(id: UUID, unitsTotal: Double, unitsCompleted: Double = 0.0, isComplete: Bool = false, user: User, goal: Goal) {
        self.id = id
        self.unitsTotal = unitsTotal
        self.unitsCompleted = unitsCompleted
        self.isComplete = isComplete
        self.user = user
        self.goal = goal
    }
    
    func incrementUnitsCompleted() {
        self.unitsCompleted += 1
        checkCompletion()
    }
        
    private func checkCompletion() {
        if self.unitsCompleted >= self.unitsTotal {
            self.unitsCompleted = self.unitsTotal  // Prevent exceeding total?
            self.isComplete = true
            print("Goal completed!")
        }
    }
}
