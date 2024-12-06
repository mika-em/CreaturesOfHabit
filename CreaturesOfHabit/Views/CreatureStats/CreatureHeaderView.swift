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

    var body: some View {
        VStack(spacing: 10) {
            Text(viewModel.creature.name)
                .font(.largeTitle)
            AnimatedImageView(
                firstImageName: "\(viewModel.creature.typeStateImage)",
                secondImageName: "\(viewModel.creature.typeStateImage)2",
                animationDuration: Constants.creatureAnimDuration
            )
            VStack(spacing: 0) {
                StatRowView(title: "Type", value: viewModel.creature.type.capitalized)
                StatRowView(title: "State", value: viewModel.creature.state.capitalized)
                StatRowView(title: "Level", value: "\(viewModel.creature.level)")
                StatRowView(title: "EXP", value: "\(Int(viewModel.creature.currentEXP))")
            }
            .padding(10)
        }
    }
}

#Preview {
    CreatureHeaderView(viewModel: CreatureStatsViewModel(
        creature: PreviewData.mockCreature,
        user: PreviewData.mockUser,
        modelContext: try! ModelContext(ModelContainer())
    ))
}
