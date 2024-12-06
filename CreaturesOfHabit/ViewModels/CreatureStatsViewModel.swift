//
//  CreatureStatsView.swift
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
    
    // Initializing the ViewModel with the Creature, User, and ModelContext
    init(creature: Creature, user: User, modelContext: ModelContext) {
        self.creature = creature
        self.user = user
        self.modelContext = modelContext
    }
    
    // Function to gain experience and save to context
    func gainExperience(_ experience: Double) {
        let gained = creature.gainEXP(experience: experience)
        if gained {
            updateCreature()
        }
    }
    
    // Function to lose experience and save to context
    func loseExperience(_ experience: Double) {
        let lost = creature.loseEXP(experience: experience)
        if lost {
            updateCreature()
        }
    }
    
    // Function to increase the level to "Adult" and save to context
    func raiseToAdult() {
        let requiredXP = Creature.xpPerLevel // 1000 EXP to level up to Adult
        if creature.level == 1 {
            gainExperience(requiredXP)
            updateCreature()
            print(creature.currentEXP, creature.state)
        }
    }
    
    // Function to decrease the level to "Baby" and save to context
    func decreaseToBaby() {
        let requiredXP = Creature.xpPerLevel // 1000 EXP to go down to Baby
        if creature.level == 2 {
            loseExperience(requiredXP)
            updateCreature()
            print(creature.currentEXP, creature.state)
        }
    }
    
    // Function to manually set stats and save to context
    func manualSetStats() {
        creature.state = "Baby"
        creature.level = 1
        creature.currentEXP = 0
        updateCreature()
    }
    
    // Function to save changes to the model context
    private func updateCreature() {
        do {
            // Save the changes to the model context
            try modelContext.save()
        } catch {
            print("Failed to save creature: \(error.localizedDescription)")
        }
    }
    
    private func saveCreature() {
        do {
            // Save the changes to the model context
            try modelContext.save()
        } catch {
            print("Failed to save creature: \(error.localizedDescription)")
        }
    }
}






