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
    
    init(type: String, name: String, state: String, level: Int, currentEXP: Double, user: User) {
        self.type = type
        self.name = name
        self.state = state
        self.level = level
        self.currentEXP = currentEXP
        self.user = user
    }
}
