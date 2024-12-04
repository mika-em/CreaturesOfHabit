//
//  CreaturesOfHabitApp.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import SwiftUI
import SwiftData

@main
struct CreaturesOfHabitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self , Creature.self, Habit.self, HabitLog.self])
        }
    }
}
