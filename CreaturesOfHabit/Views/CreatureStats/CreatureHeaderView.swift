//
//  CreatureHeaderView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-06.
//

import SwiftData
import SwiftUI

struct CreatureHeaderView: View {
    @ObservedObject var viewModel: CreatureStatsViewModel
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: 0) {
            Text(viewModel.creature.name)
                .font(Font(theme.fonts.headerFont))
                .fontWeight(.bold)
                .foregroundColor(Color(theme.colors.primaryText))
                .padding(.top, 10)
            
            VStack(spacing: 0) {
                levelBadge
                expProgressBar
            }
//            .padding(10)
            .padding(.horizontal, 20)

            AnimatedImageView(
                firstImageName: "\(viewModel.creature.typeStateImage)",
                secondImageName: "\(viewModel.creature.typeStateImage)2",
                animationDuration: Constants.creatureAnimDuration
            )
            .frame(width: 250, height: 250)
            .padding(.bottom, 20)
        }
    }

    private var levelBadge: some View {
        Text("Level \(viewModel.creature.level)")
            .font(Font(theme.fonts.bodyFont))
            .padding(10)
            .foregroundColor(Color(theme.colors.secondaryText))
            .padding(.bottom, 10)
    }

    private var expProgressBar: some View {
        VStack(alignment: .center, spacing: 5) {
            ProgressView(value: viewModel.creature.currentEXP, total: viewModel.creature.expUntilNextLevel())
                .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
                .frame(width: 170, height: 30) // Adjusted height of progress bar
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 30) // Same height as the ProgressView
                )

            Text("EXP: \(Int(viewModel.creature.currentEXP)) / \(Int(viewModel.creature.expUntilNextLevel()))")
                .font(Font(theme.fonts.bodyFont))
                .foregroundColor(Color(theme.colors.secondaryText))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CreatureHeaderView(viewModel: CreatureStatsViewModel(
        creature: PreviewData.mockCreature,
        user: PreviewData.mockUser,
        modelContext: try! ModelContext(ModelContainer())
    ))
        .environment(\.theme, ThemeManager.shared)
}
