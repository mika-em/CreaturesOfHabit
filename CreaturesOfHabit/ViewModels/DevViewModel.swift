//
//  CreatureStatsView.swift
//  CreaturesOfHabit
//
//  Created by Cheryl  Lau on 2024-12-04.
//

import Foundation
import SwiftData
import SwiftUICore

class DevViewModel: ObservableObject {
    @Published var creature: Creature
    private var modelContext: ModelContext
    
    init(creature: Creature, modelContext: ModelContext) {
        self.creature = creature
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
    
    func resetStats() {
        creature.state = "baby"
        creature.level = 1
        creature.currentEXP = 0
        updateCreature()
    }
    
    func setExp(_ exp : Double) {
        creature.currentEXP = exp
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






