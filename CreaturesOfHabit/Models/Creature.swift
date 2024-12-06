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
    var typeStateImage: String {
        "\(type.lowercased())_\(state.lowercased())"
    }
    
    @Relationship var user: User
    
    static let maxLevel = 3
    static let xpPerLevel = 1000.0
    static let baseLevel = 1
    static let baseEXP = 0.0
    
    init(type: String, name: String, state: String, user: User) {
        self.type = type
        self.name = name
        self.state = state
        level = Creature.baseLevel
        currentEXP = Creature.baseEXP
        self.user = user
    }
    
    func gainEXP(experience: Double) -> Bool {
        guard level <= Creature.maxLevel else {
            print("\(name) has reached the max level.")
            return false
        }
        
        currentEXP += experience
        while currentEXP >= expUntilNextLevel(), level < Creature.maxLevel {
            levelUp()
        }
        updateState()
        return true
    }
    
    
    
    private func levelUp() {
        if level < Creature.maxLevel {
            level += 1
            currentEXP -= Creature.xpPerLevel
            updateState()
        }
    }
    
    private func levelDown() {
        if level > Creature.baseLevel {
            level -= 1
            currentEXP = max(0, currentEXP - Creature.xpPerLevel)
            updateState()
        }
    }
    
    func loseEXP(experience: Double) -> Bool {
        while level > Creature.baseLevel {
            levelDown()
        }
        guard currentEXP - experience >= 0 else {
            print("Cannot lose more experience than the creature has.")
            return false
        }
        
        
        updateState()
        return true
    }
    
    private func expUntilNextLevel() -> Double {
        // Each level 1000 points required
        // Level 1 -> 0 (base level), Level 2 -> 1000, Level 3 -> 2000
        Double(level) * Creature.xpPerLevel
    }
    
    private func updateState() {
        switch level {
        case 1:
            state = "Baby"
        case 2:
            state = "Adult"
        case 3:
            state = "Elder"
        default:
            state = "Unknown"
        }
    }
}
