//
//  SelectHabitsView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import Foundation
import SwiftData
import SwiftUI

struct SelectHabitsView: View {
    @Query(FetchDescriptor<Habit>()) private var habits: [Habit]
    @Query(FetchDescriptor<User>()) private var users: [User]
    @State private var navigationPath = NavigationPath()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Spacer()
                Text("Pick a Habit")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ForEach(habits, id: \.self) { habit in
                    Button(action: {
                        addHabitToGoals(habit)
                        Utils.resetStackAndNavigate(
                            to: "CreatureStatsView",
                            using: &navigationPath
                        )
                    }) {
                        Text(habit.name)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationDestination(for: String.self) { destination in
                if destination == "CreatureStatsView" {
                    CreatureStatsView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
    
    private func addHabitToGoals(_ habit: Habit) {
        guard let currentUser = users.first(where: { $0.isLoggedIn }) else { return }
        
        let isAlreadyAddedToday = habitLogs(for: currentUser).contains {
            $0.habit.id == habit.id && $0.isSameDateAsToday()
        }
        guard !isAlreadyAddedToday else { return }
        
        let newLog = HabitLog(
            id: UUID(),
            unitsTotal: habit.units,
            unitsCompleted: 0,
            isComplete: false,
            date: Date(),
            user: currentUser,
            habit: habit
        )
        modelContext.insert(newLog)
        
        do { try modelContext.save() } catch { print("Error saving habit log: \(error)") }
    }
    
    private func habitLogs(for user: User) -> [HabitLog] {
        return (try? modelContext.fetch(FetchDescriptor<HabitLog>()).filter {
            $0.user.id == user.id
        }) ?? []
    }
}

#Preview {
    SelectHabitsView()
}
