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
    
    init(id: UUID, unitsTotal: Double, unitsCompleted: Double, isComplete: Bool, user: User, goal: Goal) {
        self.id = id
        self.unitsTotal = unitsTotal
        self.unitsCompleted = unitsCompleted
        self.isComplete = isComplete
        self.user = user
        self.goal = goal
    }
}
