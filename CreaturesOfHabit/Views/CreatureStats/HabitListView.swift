//
//  HabitListView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-06.
//

import SwiftData
import SwiftUI

struct HabitListView: View {
    let habitLog: [HabitLog]
    let onToggle: (HabitLog) -> Void
    @ObservedObject var viewModel: CreatureStatsViewModel

    var body: some View {
        let openHabitSlot = habitLog.count < 3

        VStack(alignment: .leading, spacing: 10) {
            Text("Habits for today")
                .font(.headline)
                .padding(.leading)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(habitLog) { habit in
                        NavigationLink(destination: HabitLogDetailsView(habitLog: habit)) {
                            HabitRowView(habitLog: habit, onToggle: onToggle, viewModel: viewModel)
                        }
                        .foregroundColor(.primary)
                    }

                    if openHabitSlot {
                        NavigationLink(destination: SelectHabitsView()) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add a Habit")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 10)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.systemGray5))
                                    .shadow(radius: 1)
                            )
                        }
                        .padding()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    HabitListView(
        habitLog: [PreviewData.mockHabitLog],
        onToggle: { _ in },
        viewModel: CreatureStatsViewModel(
            creature: PreviewData.mockCreature,
            user: PreviewData.mockUser,
            modelContext: try! ModelContext(ModelContainer())
        )
    )
}
