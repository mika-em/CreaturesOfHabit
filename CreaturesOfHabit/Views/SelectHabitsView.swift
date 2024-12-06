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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedHabitID: UUID? = nil  // Track the selected habit
//    @State var generatedHabitIndexArray: [Int]
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView{
                Spacer()
                Text("Pick a Habit")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                ForEach(0..<3) { _ in
                    var generatedHabit = generateRandomHabit()
                    Button(action: {
                        selectedHabitID = generatedHabit.id  // Update the selected habit
                        addHabitToGoals(generatedHabit)      // Add the habit to goals
                        dismiss()                  // Navigate back to MainTabView
                    }) {
                        Text(generatedHabit.name)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedHabitID == generatedHabit.id ? Color.purple : Color(.systemGray5))
                            .foregroundColor(selectedHabitID == generatedHabit.id ? .white : .primary)
                            .cornerRadius(10)
                    }
                }
            }
            Spacer()
        }.onAppear{
            if habits.isEmpty{
                print("Habits are empty, Reseeding...")
                DataSeeder.seedHabits(modelContext: modelContext)
                print("Populated Habits. Seeding Complete!")
                
            }
        }
        .padding()
    }
    
    private func addHabitToGoals(_ habit: Habit) {
        guard let currentUser = users.first(where: { $0.isLoggedIn }) else { return }
        
        let isAlreadyAddedToday = getUserHabitLogs(for: currentUser).contains {
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
    
    private func getUserHabitLogs(for user: User) -> [HabitLog] {
        return (try? modelContext.fetch(FetchDescriptor<HabitLog>()).filter {
            $0.user.id == user.id
        }) ?? []
    }
    
    private func generateRandomHabit() -> Habit {
        let randomInt = Int.random(in: 0..<habits.count)
//        generatedHabitIndexArray.append(randomInt)
        return habits[randomInt]
    }
}
//
//#Preview {
//    SelectHabitsView()
//}
