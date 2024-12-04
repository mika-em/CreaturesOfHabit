//
//  SelectGoalsView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import SwiftUI
import SwiftData
import Foundation

//let goals = ["Drink Water", "Walk Dog", "Meditate"]

struct SelectHabitsView: View {
    @Query(FetchDescriptor<Habit>()) private var habits: [Habit]
    @State private var selectedHabits: Set<UUID> = []
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Pick a Habit")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            ForEach(habits, id: \.self) { habit in
                Text(habit.name)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedHabits.contains(habit.id) ? Color.purple : Color(.systemGray5))
                    .foregroundColor(selectedHabits.contains(habit.id) ? .white : .primary)
                    .cornerRadius(25)
                    .onTapGesture {
                        if selectedHabits.contains(habit.id) {
                            selectedHabits.remove(habit.id)
                        } else {
                            selectedHabits.insert(habit.id)
                        }
                    }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SelectHabitsView()
}
