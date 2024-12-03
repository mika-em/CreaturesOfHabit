//
//  Creature.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-13.
//

import Foundation
import SwiftData

@Model
class Creature {
    var id: UUID = UUID()
    var type: String
    var name: String
    var state: String
    var level: Int
    var currentEXP: Double
    @Relationship var user: User
    
    static let maxLevel = 3
    static let xpPerLevel = 1000.0
    static let baseLevel = 1
    static let baseEXP = 0.0
    
    init(type: String, name: String, state: String, user: User) {
        self.type = type
        self.name = name
        self.state = state
        self.level = Creature.baseLevel
        self.currentEXP = Creature.baseEXP
        self.user = user
    }
    
    func gainEXP(experience: Double) -> Bool {
        guard level < Creature.maxLevel else {
            print("\(name) has reached the max level.")
            return false
        }
        
        self.currentEXP += experience
        while self.currentEXP >= expUntilNextLevel() && self.level < Creature.maxLevel {
            levelUp()
        }
        return true
    }
    
    private func levelUp() {
        if level < Creature.maxLevel {
            self.level += 1
            self.currentEXP -= Creature.xpPerLevel
        }
    }
    
    private func expUntilNextLevel() -> Double {
        // Each level 1000 points required
        // Level 1 -> 0 (base level), Level 2 -> 1000, Level 3 -> 2000
        return Double(level) * Creature.xpPerLevel
    }
}
