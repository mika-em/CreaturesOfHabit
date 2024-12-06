//
//  HabitLogDetailsView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-03.
//

import SwiftUI

struct HabitLogDetailsView: View {
    var habitLog: HabitLog

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Habit Log Details")
                .font(.title)
                .bold()

            Group {
                // Text("ID: \(habitLog.id.uuidString)")
                Text("Habit: \(habitLog.habit.name)")
                Text("Units Total: \(habitLog.unitsTotal)")
                Text("Units Completed: \(habitLog.unitsCompleted)")
                Text("Completion Status: \(habitLog.isComplete ? "Complete" : "Incomplete")")
                Text("Date: \(Utils.formattedDate(habitLog.date))")
            }
            .font(.body)
            .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding()
    }
}

#Preview {
    HabitLogDetailsView(habitLog: PreviewData.mockHabitLog)
}
