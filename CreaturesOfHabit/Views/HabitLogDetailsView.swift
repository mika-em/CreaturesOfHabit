//
//  HabitLogDetailsView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-03.
//

import SwiftUI

struct HabitLogDetailsView: View {
    var habitLog: HabitLog
    @Environment(\.theme) private var theme
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: theme.gradients.alternateGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    Text("Habit Log Details")
                        .font(Font(theme.fonts.headerFont))
                        .bold()
                        .foregroundColor(Color(theme.colors.primaryText))
                        .padding(.bottom, 20)

                    Group {
                        Text("Habit: \(habitLog.habit.name)")
                            .font(Font(theme.fonts.bodyFont))
                            .foregroundColor(Color(theme.colors.secondaryText))

                        Text("Units Total: \(habitLog.unitsTotal)")
                            .font(Font(theme.fonts.bodyFont))
                            .foregroundColor(Color(theme.colors.secondaryText))

                        Text("Units Completed: \(habitLog.unitsCompleted)")
                            .font(Font(theme.fonts.bodyFont))
                            .foregroundColor(Color(theme.colors.secondaryText))

                        Text("Completion Status: \(habitLog.isComplete ? "Complete" : "Incomplete")")
                            .font(Font(theme.fonts.bodyFont))
                            .foregroundColor(habitLog.isComplete ? .green : .red)

                        Text("Date: \(Utils.formattedDate(habitLog.date))")
                            .font(Font(theme.fonts.bodyFont))
                            .foregroundColor(Color(theme.colors.secondaryText))
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(radius: 4)
                )
                .padding()

                Spacer()
            }
        }
    }
}

#Preview {
    HabitLogDetailsView(habitLog: PreviewData.mockHabitLog)
        .environment(\.theme, ThemeManager.shared)
}
