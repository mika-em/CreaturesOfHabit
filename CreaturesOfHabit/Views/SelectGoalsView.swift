//
//  SelectGoalsView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import SwiftUI
import Foundation

let goals = ["Drink Water", "Walk Dog", "Meditate"]

struct SelectGoalsView: View {
    @State private var selectedGoals: Set<String> = []
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Pick a Habit")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            ForEach(goals, id: \.self) { goal in
                Text(goal)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedGoals.contains(goal) ? Color.purple : Color(.systemGray5))
                    .foregroundColor(selectedGoals.contains(goal) ? .white : .primary)
                    .cornerRadius(25)
                    .onTapGesture {
                        if selectedGoals.contains(goal) {
                            selectedGoals.remove(goal)
                        } else {
                            selectedGoals.insert(goal)
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
