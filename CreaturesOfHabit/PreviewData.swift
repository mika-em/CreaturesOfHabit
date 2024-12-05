import Foundation

// Preview data
enum PreviewData {
    static let mockCreature: Creature = {
        let user = User(
            username: "JohnDoe",
            password: "password123"
        )
        let creature = Creature(
            type: "Slime",
            name: "Slimey",
            state: "Baby",
            user: user
        )
        // Set the user's creature to avoid circular reference issues
        user.creature = creature
        // Optionally, pre-set experience and level for the mock if needed
        creature.currentEXP = 200.0
        creature.level = 1
        return creature
    }()
    
    static let mockUser: User = {
        let user = User(
            username: "JohnDoe",
            password: "password123"
        )
        // Assign creature to the user (avoiding circular reference)
        let creature = Creature(
            type: "Phoenix",
            name: "Fiery",
            state: "Active",
            user: user
        )
        user.creature = creature // Set the creature for the user
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
