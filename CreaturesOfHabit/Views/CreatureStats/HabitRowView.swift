//
//  HabitRowView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-06.
//

import SwiftData
import SwiftUI

struct HabitRowView: View {
    let habitLog: HabitLog
    let onToggle: (HabitLog) -> Void
    @ObservedObject var viewModel: CreatureStatsViewModel

    var body: some View {
        HStack {
            // Info Icon for Navigation
            NavigationLink(destination: HabitLogDetailsView(habitLog: habitLog)) {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .font(.title2)
                    .frame(width: 30)
            }
            .buttonStyle(PlainButtonStyle()) // Prevents button appearance

            Spacer()

            VStack(alignment: .leading) {
                Text(habitLog.habit.name)
                    .font(.body)
                HStack {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.yellow)
                    Text("\(habitLog.exp)")
                        .font(.subheadline)
                }
                Text("\(String(format: "%.2f", habitLog.unitsCompleted))/\(String(format: "%.2f", habitLog.unitsTotal))")
            }
            .padding(.leading)

            Spacer()

            // Checkmark Circle for Incrementing
            Button(action: {
                onToggle(habitLog) // Increment habit progress
            }) {
                Image(systemName: habitLog.isComplete ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(habitLog.isComplete ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle()) // Prevents button appearance
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
                .shadow(radius: 2)
        )
        // Row click to increment (excluding NavigationLink area)
        .onTapGesture {
            onToggle(habitLog)
        }
    }
}

#Preview {
    HabitRowView(
        habitLog: PreviewData.mockHabitLog,
        onToggle: { _ in },
        viewModel: CreatureStatsViewModel(
            creature: PreviewData.mockCreature,
            user: PreviewData.mockUser,
            modelContext: try! ModelContext(ModelContainer())
        )
    )
}
