//
//  CreatureStatsView.swift
//  CreaturesOfHabit
//
//  Created by Cheryl  Lau on 2024-12-04.
//

import Foundation
import SwiftData

class CreatureStatsViewModel: ObservableObject {
    @Published var creature: Creature
    @Published var user: User
    
    // Initializing the ViewModel with the Creature and User
    init(creature: Creature, user: User) {
        self.creature = creature
        self.user = user
    }
    
    // Fetches the creature's current experience and level
    func gainExperience(_ experience: Double) {
        let gained = creature.gainEXP(experience: experience)
        if gained {
            updateCreature()
        }
    }
    
    // Update the creature (to reflect changes in EXP, level, etc.)
    private func updateCreature() {
        // Save changes to the model context, if necessary
        // This logic depends on how you manage your model context.
    }
}
