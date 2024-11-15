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

struct SelectGoalsView: View {
    @Query(FetchDescriptor<Goal>()) private var goals: [Goal]
    @State private var selectedGoals: Set<UUID> = []
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Pick a Habit")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            ForEach(goals, id: \.self) { goal in
                Text(goal.name)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedGoals.contains(goal.id) ? Color.purple : Color(.systemGray5))
                    .foregroundColor(selectedGoals.contains(goal.id) ? .white : .primary)
                    .cornerRadius(25)
                    .onTapGesture {
                        if selectedGoals.contains(goal.id) {
                            selectedGoals.remove(goal.id)
                        } else {
                            selectedGoals.insert(goal.id)
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
    SelectGoalsView()
}
