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
//    @Query(FetchDescriptor<Creature>()) private var creature: [Creature]
    @State private var creature: Creature = PreviewData.mockCreature
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: CreatureStatsViewModel
    @Environment(\.theme) private var theme
    
    
    var body: some View {
        let todayHabits = habitLogs.filter { $0.isSameDateAsToday() }
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: creatureGradient(),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
//                    if let creature = creature.first {
                        CreatureHeaderView(viewModel: viewModel)
//                    } else {
//                        Text("No creature found.")
//                            .font(.title)
//                            .foregroundColor(.gray)
//                    }
                    
                    HabitListView(habitLog: todayHabits, onToggle: completeHabitToggle, viewModel: viewModel)
                }
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
    
    
    private func creatureGradient() -> Gradient {
        // Return a gradient based on creature type, this could be based on the theme
//        if let creature = creature.first {
            switch creature.type.lowercased() {
            case "slime":
                return Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.6)])
            case "chocobo":
                return Gradient(colors: [Color.yellow.opacity(0.2), Color.orange.opacity(0.6)])
            case "dragon":
                return Gradient(colors: [Color.red.opacity(0.2), Color.orange.opacity(0.6)])
            default:
                return Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.6)])
            }
//        }
        return Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.6)])
    }
}

#Preview {
    CreatureStatsView(viewModel: CreatureStatsViewModel(
        creature: PreviewData.mockCreature,
        user: PreviewData.mockUser,
        modelContext: try! ModelContext(ModelContainer())
    ))
}
