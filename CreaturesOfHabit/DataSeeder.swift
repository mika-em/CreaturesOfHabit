//
//  DataSeeder.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-27.
//

import SwiftData

enum DataSeeder {
    static func seedHabits(modelContext: ModelContext) {
        let baseRate: Double = 100
        let ultraLowRate: Double = baseRate * 0.05
        let lowRate: Double = baseRate * 0.10
        let medRate: Double = baseRate * 0.25
        let highRate: Double = baseRate * 0.50
        do {
            // Check if goals are already loaded
            let existingGoals = try modelContext.fetch(FetchDescriptor<Habit>())
            if existingGoals.isEmpty {
                let defaultGoals = [
                    Habit(name: "Drink Water", units: 0, unitsLower: ultraLowRate, unitsUpper: lowRate, ExpRate: baseRate),
                    Habit(name: "Walk Dog", units: 0, unitsLower: lowRate, unitsUpper: medRate, ExpRate: baseRate),
                    Habit(name: "Meditate", units: 0, unitsLower: medRate, unitsUpper: highRate, ExpRate: baseRate),
                    Habit(name: "Routine House Cleaning", units: 0, unitsLower: medRate, unitsUpper: highRate, ExpRate: baseRate),
                    Habit(name: "Exercise/Workout", units: 0, unitsLower: medRate, unitsUpper: highRate, ExpRate: baseRate),
                    Habit(name: "Stretch", units: 0, unitsLower: medRate, unitsUpper:highRate, ExpRate: baseRate),
                    Habit(name: "Study", units: 0, unitsLower: medRate, unitsUpper: highRate, ExpRate: baseRate),
                    Habit(name: "Sleep Early", units: 0, unitsLower: medRate, unitsUpper: highRate, ExpRate: baseRate),
                    Habit(name: "Cook At Home", units: 0, unitsLower: medRate, unitsUpper: highRate, ExpRate: baseRate),
                    Habit(name: "Avoid Junk Food", units: 0, unitsLower: lowRate, unitsUpper: medRate, ExpRate: baseRate),
                    Habit(name: "Floss Teeth", units: 0, unitsLower: ultraLowRate, unitsUpper: lowRate, ExpRate: baseRate),
                    Habit(name: "No Phone Before Bed", units: 0, unitsLower: ultraLowRate, unitsUpper: lowRate, ExpRate: baseRate),
                    Habit(name: "Moisturize Hands", units: 0, unitsLower: ultraLowRate, unitsUpper: lowRate, ExpRate: baseRate),
                    Habit(name: "Do Dishes", units: 0, unitsLower: lowRate, unitsUpper: medRate, ExpRate: baseRate),
                ]
                
                defaultGoals.forEach { modelContext.insert($0) }
                try modelContext.save()
                print("Goals seeded successfully.")
            } else {
                print("Goals already exist.")
            }
        } catch {
            print("Error seeding goals: \(error.localizedDescription)")
        }
    }
    
    // Clear data if needed
    static func clearAllData(modelContext: ModelContext) {
        do {
            let habit = try modelContext.fetch(FetchDescriptor<Habit>())
            habit.forEach { modelContext.delete($0) }
            try modelContext.save()
            print("All data cleared.")
        } catch {
            print("Failed to clear data: \(error.localizedDescription)")
        }
    }
}
