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
    @Environment(\.theme) private var theme

    var body: some View {
        HStack {
            // Info Icon for Navigation
            NavigationLink(destination: HabitLogDetailsView(habitLog: habitLog)) {
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .frame(width: 50)
            }
            .buttonStyle(PlainButtonStyle()) // Prevents button appearance

            Spacer()

            VStack(alignment: .leading) {
                Text(habitLog.habit.name)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color(theme.colors.primaryText))

                HStack {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.yellow)
                    Text("\(formattedXP(for: habitLog.exp))")
                        .font(.subheadline)
                        .foregroundColor(Color(theme.colors.secondaryText))
                }

                Text("\(formattedUnits(for: habitLog.unitsCompleted))/\(formattedUnits(for: habitLog.unitsTotal))")
                    .font(.subheadline)
                    .foregroundColor(Color(theme.colors.secondaryText))
            }
            .padding(.leading)

            Spacer()

            // Checkmark Circle for Incrementing
            Button(action: {
                onToggle(habitLog) // Increment habit progress
            }) {
                Image(systemName: habitLog.isComplete ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(habitLog.isComplete ? .blue : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding(.horizontal)
        .onTapGesture {
            onToggle(habitLog)
        }
    }
    
    private func formattedXP(for xp: Double) -> String {
           return String(format: "%.0f", xp)  // Removes trailing zeros
       }
       
       // Helper function to format units
       private func formattedUnits(for units: Double) -> String {
           return String(format: "%.1f", units)  // Keeps 2 decimal places
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
