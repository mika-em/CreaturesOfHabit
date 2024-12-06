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
    @Environment(\.theme) private var theme
    
    @State private var selectedCreature: Creature?

    var body: some View {
        let todayHabits = habitLogs.filter { $0.isSameDateAsToday() }
        
        ZStack {
            Color.clear
                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(
                gradient: creatureGradient(),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 5) {
                           if let creature = creature.first {
                               CreatureHeaderView(viewModel: viewModel)
                                   .padding(.top, 30)
                           }
                           
                           ScrollView {
                               VStack(spacing: 10) {
                                   HabitListView(habitLog: todayHabits, onToggle: completeHabitToggle, viewModel: viewModel)
                                       .padding(.bottom, 20)
                                       .padding(.top, 0)
                               }
                           }
                           .padding(.horizontal, 20)
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
        // Ensure we are using the selected creature's type
        if let creature = selectedCreature {
            switch creature.type.lowercased() {
            case "slime":
                return Gradient(colors: [Color.green.opacity(0.3), Color.cyan.opacity(0.6)])
            case "chocobo":
                return Gradient(colors: [Color.yellow.opacity(0.2), Color.orange.opacity(0.7)])
            case "dragon":
                return Gradient(colors: [Color.orange.opacity(0.5), Color.red.opacity(0.7)])
            default:
                return Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.6)])
            }
        }
        return Gradient(colors: [Color.blue.opacity(0.3), Color.cyan.opacity(0.6)]) // Fallback gradient
    }
}

#Preview {
    CreatureStatsView(viewModel: CreatureStatsViewModel(
        creature: PreviewData.mockCreature,
        user: PreviewData.mockUser,
        modelContext: try! ModelContext(ModelContainer())
    ))
}
