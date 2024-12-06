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
    
    private let placeholderCreature = CreaturePlaceholder(
        type: "Slime",
        name: "Slimey",
        state: "Baby",
        level: 1,
        currentEXP: 200.0,
        expUntilNextLevel: 1000.0,
        typeStateImage: "slime_baby"
    )
    
    private let placeholderHabits = [
        HabitPlaceholder(icon: "drop.fill", name: "Drink water", reward: 5, isComplete: true),
        HabitPlaceholder(icon: "toothbrush.fill", name: "Brush teeth", reward: 5, isComplete: false),
        HabitPlaceholder(icon: "face.smiling", name: "Wash my face", reward: 5, isComplete: true),
    ]
    
    var body: some View {
        ZStack {
            //TODO: make lighter
            LinearGradient(
                            gradient: creatureGradient(),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()


            ScrollView {
                VStack(spacing: 20) {
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
                .padding(.horizontal, 20)
            }
        }
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
    
    private func creatureGradient() -> Gradient {
            if let creature = creature.first {
                switch creature.type.lowercased() {
                case "slime":
                    return Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.6)])
                case "chocobo":
                    return Gradient(colors: [Color.yellow.opacity(0.2), Color.orange.opacity(0.6)])
                case "dragon":
                    return Gradient(colors: [Color.red.opacity(0.2), Color.purple.opacity(0.6)])
                default:
                    return Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.6)])
                }
            }
            return Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.6)])
        }
    }
    

// MARK: - Creature Header
struct CreatureHeader: View {
    let creature: Creature
    @Environment(\.theme) private var theme

   
    var body: some View {
        VStack(spacing: 30) {
            creatureName
            creatureBody
            statsSection
        }
        .padding(.horizontal, 10)
    }

    // MARK: - Subviews
    private var creatureName: some View {
        Text(creature.name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .shadow(color: Color.blue.opacity(0.8), radius: 10, x: 0, y: 0)
            .padding(.top, 10)
    }

    private var creatureBody: some View {

            AnimatedImageView(
                firstImageName: "\(creature.typeStateImage)",
                secondImageName: "\(creature.typeStateImage)2",
                animationDuration: 0.3
            )
            .frame(width: 250, height: 250)
        }

    private var statsSection: some View {
        VStack(spacing: 20) {
            levelBadge

            expProgressBar
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.2), radius: 10)
        )
        .padding(.horizontal, 20)
    }

    private var levelBadge: some View {
        Text("Level \(creature.level)")
            .font(.headline)
            .fontWeight(.bold)
            .padding(10)
            .background(
                Capsule()
                    .fill(Color.blue.opacity(0.8))
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
            )
            .foregroundColor(.white)
            .padding(.bottom, 10)
    }

    private var expProgressBar: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("EXP: \(Int(creature.currentEXP)) / \(Int(creature.expUntilNextLevel()))")
                .font(.subheadline)
                .foregroundColor(.white)

            ProgressView(value: creature.currentEXP, total: creature.expUntilNextLevel())
                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                .frame(height: 10)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white.opacity(0.2))
                )
        }
        .padding(.horizontal, 20)
    }
}
// MARK: - Creature Header Placeholder - to be deleted
struct CreatureHeaderPlaceholder: View {
    let creature: CreaturePlaceholder
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
                .frame(height: 40)

    
            VStack(spacing: 10) {
                Text(creature.name)
                    .font(Font(theme.fonts.headerFont))
                    .foregroundColor(Color(theme.colors.primaryText))
                Text("Level \(creature.level)")
                    .font(Font(theme.fonts.bodyFont))
                    .foregroundColor(Color(theme.colors.secondaryText))

                // XP Progress Bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray5))
                        .frame(height: 10)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: progressBarWidth(), height: 10)
                        .animation(.easeInOut, value: creature.currentEXP)
                }
                .frame(maxWidth: 200)
                .padding(.top, 5)

                // XP Text
                Text("\(Int(creature.currentEXP)) / \(Int(creature.expUntilNextLevel)) XP")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            // Animated Slime with Glow
            AnimatedImageView(
                firstImageName: "\(creature.typeStateImage)",
                secondImageName: "\(creature.typeStateImage)2",
                animationDuration: 0.3
            )
            .frame(width: 250, height: 250)
            .padding(.top, -60) // Move the slime up slightly by reducing top padding
        }
    }

    // Helper function to calculate progress bar width
    private func progressBarWidth() -> CGFloat {
        let maxWidth: CGFloat = 200 // Max width of the progress bar
        let progress = creature.currentEXP / creature.expUntilNextLevel
        return maxWidth * CGFloat(progress)
    }
}

// MARK: - Goal List to show goals for today
struct HabitList: View {
    let habitLog: [HabitLog]
    let onToggle: (HabitLog) -> Void
    @Environment(\.theme) private var theme


    var body: some View {
        VStack(alignment: .center, spacing: 10) { // Center alignment
            Text("Daily Habits")
                .fontWeight(.medium)
                .multilineTextAlignment(.center) // Center the text
                .frame(maxWidth: .infinity) // Take full width to center within VStack

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
    @Environment(\.theme) private var theme
    var body: some View {
        VStack(alignment: .center, spacing: 10) { // Center alignment
            Text("Daily Habits")
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center) // Center the text
                .frame(maxWidth: .infinity) // Take full width to center within VStack

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

// MARK: - Habit Row
struct HabitRow: View {
    let habitLog: HabitLog
    let onToggle: (HabitLog) -> Void

    var body: some View {
        HStack(spacing: 15) {
            // Habit Name
            Text(habitLog.habit.name)
                .font(.subheadline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)

            // XP Text
            Text("5 XP")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Toggle Completion Button
            Button(action: {
                onToggle(habitLog)
            }) {
                Image(systemName: habitLog.isComplete ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(habitLog.isComplete ? .green : .gray)
                    .font(.title2)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)) // Adjust content padding
              .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30) // More circular shape
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding(.horizontal)
    }
}

// MARK: - Habit Row Placeholder
struct HabitRowPlaceholder: View {
    @Environment(\.theme) private var theme
    let habit: HabitPlaceholder

    var body: some View {
        HStack(spacing: 15) {
            Text(habit.name)
                .font(Font(theme.fonts.bodyFont))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(habit.reward) XP")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Placeholder Checkmark
            Image(systemName: habit.isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundColor(habit.isComplete ? .green : .gray)
                .font(.title2)
        }
        .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)) 
              .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30) // More circular shape
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding(.horizontal)
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
    let expUntilNextLevel: Double
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
