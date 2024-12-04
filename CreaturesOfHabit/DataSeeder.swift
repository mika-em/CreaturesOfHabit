//
//  DataSeeder.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-27.
//

import SwiftData

enum DataSeeder {
    static func seedHabits(modelContext: ModelContext) {
        do {
            // Check if goals are already loaded
            let existingGoals = try modelContext.fetch(FetchDescriptor<Habit>())
            if existingGoals.isEmpty {
                let defaultGoals = [
                    Habit(name: "Drink Water", units: 0, unitsLower: 0, unitsUpper: 0, ExpRate: 0),
                    Habit(name: "Walk Dog", units: 0, unitsLower: 0, unitsUpper: 0, ExpRate: 0),
                    Habit(name: "Meditate", units: 0, unitsLower: 0, unitsUpper: 0, ExpRate: 0),
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
