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

    private let placeholderCreature = CreaturePlaceholder(
        type: "Slime",
        name: "Slimey",
        state: "Baby",
        level: 1,
        currentEXP: 200.0,
        expToNextLevel: 1000.0,
        typeStateImage: "slime_baby"
    )

    private let placeholderHabits = [
        HabitPlaceholder(icon: "drop.fill", name: "Drink water", reward: 5, isComplete: true),
        HabitPlaceholder(icon: "toothbrush.fill", name: "Brush teeth", reward: 5, isComplete: false),
        HabitPlaceholder(icon: "face.smiling", name: "Wash my face", reward: 5, isComplete: true),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                if let creature = creature.first {
                    CreatureHeader(creature: viewModel.creature)
                } else {
                    CreatureHeaderPlaceholder(creature: placeholderCreature)
                }
                let todayHabits = habitLogs.filter { $0.isSameDateAsToday() }
                if todayHabits.isEmpty {
                    HabitListPlaceholder(habits: placeholderHabits)
                } else {
                    HabitList(habitLog: todayHabits, onToggle: completeHabitToggle)
                }
            }
        }
//        .onAppear {
//            Utils.replaceRootView(with: self)
//        }
    }

    private func completeHabitToggle(for log: HabitLog) {
        if log.unitsCompleted < log.unitsTotal {
            log.incrementUnitsCompleted()
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save habit completion: \(error.localizedDescription)")
        }
    }
}

// MARK: - Creature Header for Creature Stats

struct CreatureHeader: View {
    let creature: Creature

    var body: some View {
        VStack(spacing: 10) {
            Text(creature.name)
                .font(.largeTitle)
            AnimatedImageView(firstImageName: "\(creature.typeStateImage)", secondImageName: "\(creature.typeStateImage)2", animationDuration: 0.3)
            VStack(spacing: 0) {
                StatRow(title: "Type", value: creature.type.capitalized)
                StatRow(title: "State", value: creature.state.capitalized)
                StatRow(title: "Level", value: "\(creature.level)")
                StatRow(title: "EXP", value: "\(Int(creature.currentEXP))")
            }
            .padding(10)
        }
    }
}

// MARK: - Creature Header Placeholder - to be deleted

struct CreatureHeaderPlaceholder: View {
    let creature: CreaturePlaceholder

    var body: some View {
        VStack(spacing: 10) {
            Text(creature.name)
                .font(.largeTitle)

            Image(creature.typeStateImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .padding()

            VStack(spacing: 0) {
                StatRow(title: "Type", value: creature.type)
                StatRow(title: "State", value: creature.state)
                StatRow(title: "Level", value: "\(creature.level)")
                StatRow(title: "EXP", value: "\(Int(creature.currentEXP)) / \(Int(creature.expToNextLevel))")
            }
            .padding(10)
        }
    }
}

// MARK: - Goal List to show goals for today

struct HabitList: View {
    let habitLog: [HabitLog]
    let onToggle: (HabitLog) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Habits for today")
                .font(.headline)
                .padding(.leading)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(habitLog) { habit in
                        HabitRow(habitLog: habit, onToggle: onToggle)
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Goal List Placeholder

struct HabitListPlaceholder: View {
    let habits: [HabitPlaceholder]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Goals for today")
                .font(.headline)
                .padding(.leading)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(habits) { habit in
                        HabitRowPlaceholder(habit: habit)
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Goal Row to display each goal

struct HabitRow: View {
    let habitLog: HabitLog
    let onToggle: (HabitLog) -> Void

    var body: some View {
        HStack {
            Image(systemName: "circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray5))
                )

            VStack(alignment: .leading) {
                Text(habitLog.habit.name)
                    .font(.body)
                HStack {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.yellow)
                    Text("5")
                        .font(.subheadline)
                }
            }
            .padding(.leading)

            Spacer()

            Button(action: {
                onToggle(habitLog)
            }) {
                Image(systemName: habitLog.isComplete ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(habitLog.isComplete ? .green : .gray)
                    .font(.title2)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
                .shadow(radius: 2)
        )
    }
}

// MARK: - Placeholder for Goal Row

struct HabitRowPlaceholder: View {
    let habit: HabitPlaceholder

    var body: some View {
        HStack {
            Image(systemName: habit.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray5))
                )

            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.body)
                HStack {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.yellow)
                    Text("\(habit.reward)")
                        .font(.subheadline)
                }
            }
            .padding(.leading)

            Spacer()

            Image(systemName: habit.isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundColor(habit.isComplete ? .green : .gray)
                .font(.title2)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
                .shadow(radius: 2)
        )
    }
}

// MARK: - General Stat Row Component

struct StatRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .multilineTextAlignment(.center)
        .padding(.vertical, 1)
        .padding(.horizontal, 60)
    }
}

// MARK: - Placeholder Creature and Goal

struct CreaturePlaceholder {
    let type: String
    let name: String
    let state: String
    let level: Int
    let currentEXP: Double
    let expToNextLevel: Double
    let typeStateImage: String
}

struct HabitPlaceholder: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    let reward: Int
    let isComplete: Bool
}

// MARK: - Preview

#Preview {
    CreatureStatsView(viewModel: CreatureStatsViewModel(creature: PreviewData.mockUser.creature!, user: PreviewData.mockUser))
}
