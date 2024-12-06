import Foundation
import SwiftUICore

// Preview data
enum PreviewData {
    static let mockCreature: Creature = {
        let user = User(
            username: "JohnDoe",
            password: "password123"
        )
        let creature = Creature(
            type: "dragon",
            name: "Drake",
            state: "Baby",
            user: user
        )
        user.creature = creature
        creature.currentEXP = 300.0
        creature.level = 2
        return creature
    }()
    
    static let mockUser: User = {
        let user = User(
            username: "JohnDoe",
            password: "password123"
        )
        let creature = Creature(
            type: "chocobo",
            name: "Chocobo",
            state: "Baby",
            user: user
        )
        user.creature = creature
        return user
    }()
    
    static let mockHabit = Habit(
        name: "Morning Jog",
        units: 5,
        unitsLower: 3,
        unitsUpper: 10,
        ExpRate: 1.5
    )
    
    static let mockHabitLog = HabitLog(
        id: UUID(),
        unitsTotal: 5,
        unitsCompleted: 2,
        isComplete: false,
        date: Date(),
        user: mockUser,
        habit: mockHabit
    )
    
}


