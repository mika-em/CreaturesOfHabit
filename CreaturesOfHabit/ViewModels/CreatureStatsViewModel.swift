//
//  CreatureStatsViewModel.swift
//  CreatureStatsViewModel.swift
//  CreaturesOfHabit
//
//  Created by Cheryl  Lau on 2024-12-04.
//

import Foundation
import SwiftData
import SwiftUICore

class CreatureStatsViewModel: ObservableObject {
    @Published var creature: Creature
    @Published var user: User
    private var modelContext: ModelContext
    
    init(creature: Creature, user: User, modelContext: ModelContext) {
        self.creature = creature
        self.user = user
        self.modelContext = modelContext
    }
    
    func gainExperience(_ experience: Double) {
        let gained = creature.gainEXP(experience: experience)
        if gained {
            updateCreature()
        }
    }
    
    func loseExperience(_ experience: Double) {
        let lost = creature.loseEXP(experience: experience)
        if lost {
            updateCreature()
        }
    }
    
    func raiseToAdult() {
        if creature.level == 1 {
            gainExperience(500)
            updateCreature()
            print(creature.currentEXP, creature.state)
        }
    }

    func decreaseToBaby() {
        if creature.level == 2 {
            loseExperience(500)
            updateCreature()
            print(creature.currentEXP, creature.state)
        }
    }
    
    func manualSetStats() {
        creature.state = "Baby"
        creature.level = 1
        creature.currentEXP = 0
        updateCreature()
    }
    
    private func updateCreature() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save creature: \(error.localizedDescription)")
        }
    }
}






