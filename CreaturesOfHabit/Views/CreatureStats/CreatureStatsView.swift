//
//  CreatureStatsView.swift
//  CreaturesOfHabit
//
//  Created by Mika M on 2024-12-03.
//

import SwiftData
import SwiftUI

struct CreatureStatsView: View {
    @Query(FetchDescriptor<HabitLog>()) private var habitLogs: [HabitLog]
    @Query(FetchDescriptor<Creature>()) private var creature: [Creature]
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: CreatureStatsViewModel

    var body: some View {
        let todayHabits = habitLogs.filter { $0.isSameDateAsToday() }

        ScrollView {
            VStack(spacing: 10) {
                if let creature = creature.first {
                    CreatureHeaderView(viewModel: viewModel)
                } else {
                    Text("No creature found.")
                        .font(.title)
                        .foregroundColor(.gray)
                }

                HabitListView(habitLog: todayHabits, onToggle: completeHabitToggle, viewModel: viewModel)
            }
        }
    }

    private func completeHabitToggle(for log: HabitLog) {
        if log.unitsCompleted < log.unitsTotal {
            let isComplete = log.incrementUnitsCompleted()
            if isComplete { viewModel.creature.gainEXP(experience: log.unitsCompleted * log.exp) }
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save habit completion: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CreatureStatsView(viewModel: CreatureStatsViewModel(
        creature: PreviewData.mockCreature,
        user: PreviewData.mockUser,
        modelContext: try! ModelContext(ModelContainer())
    ))
}
