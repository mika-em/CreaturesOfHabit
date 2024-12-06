//
//  DevView.swift
//  CreaturesOfHabit
//
//  Created by Cheryl  Lau on 2024-12-05.
//

import SwiftUI
import SwiftData

struct DevView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var devViewModel: DevViewModel
    @Query(FetchDescriptor<HabitLog>()) private var habitLogs: [HabitLog]
    
    @State private var expInput: String = ""
    
    var body: some View {
        VStack {
            Text("Dev Tools")
                .font(.largeTitle)
                .fontWeight(.bold)
            Button(action: {
                devViewModel.raiseToAdult()
            }) {
                Text("Add EXP")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                devViewModel.resetStats()
            }) {
                Text("Reset Creature Stats")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                clearHabitLogData()
            }) {
                Text("Clear Habit Log Data")
                    .font(.headline)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            
            VStack(spacing: 20) {
                Text("Set Experience")
                    .font(.title2)
                    .padding(.top, 20)
                
                HStack {
                    TextField("Enter EXP amount", text: $expInput)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    Button(action: {
                        if let expAmount = Double(expInput), expAmount > 0 {
                            devViewModel.setExp(expAmount)
                            expInput = ""
                        }
                    }) {
                        Text("Set EXP")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 10)
    }
    
    private func clearHabitLogData() {
        for habitLog in habitLogs {
            modelContext.delete(habitLog)
        }
        do {
            try modelContext.save()
        } catch {
            print("Error clearing habit log data: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    DevView(
//        creatureStatsViewModel: CreatureStatsViewModel(creature: Creature(), user: User(), modelContext: ModelContext())
//    )
//}





