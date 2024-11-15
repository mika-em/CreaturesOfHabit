//
//  DataSeeder.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-27.
//

import SwiftData

struct DataSeeder {
    static func seedGoals(modelContext: ModelContext) {
        do {
            // Check if goals are already loaded
            let existingGoals = try modelContext.fetch(FetchDescriptor<Goal>())
            if existingGoals.isEmpty {
                let defaultGoals = [
                    Goal(name: "Drink Water", units: 0, unitsLower: 0, unitsUpper: 0, ExpRate: 0),
                    Goal(name: "Walk Dog", units: 0, unitsLower: 0, unitsUpper: 0, ExpRate: 0),
                    Goal(name: "Meditate", units: 0, unitsLower: 0, unitsUpper: 0, ExpRate: 0)
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
            let goals = try modelContext.fetch(FetchDescriptor<Goal>())
            goals.forEach { modelContext.delete($0) }
            try modelContext.save()
            print("All data cleared.")
        } catch {
            print("Failed to clear data: \(error.localizedDescription)")
        }
    }
}
