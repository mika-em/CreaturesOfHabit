//
//  SelectCreatureView.swift
//  CreaturesOfHabit
//
//  Created by Cheryl  Lau on 2024-12-04.
//

import SwiftUI

struct SelectCreatureView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCreature: PredefinedCreature? = nil
    @ObservedObject var userViewModel: UserViewModel
    @State private var showHatchPetView = false

    var body: some View {
        VStack {
            Text("Select your creature")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // List of predefined creatures
            List(predefinedCreatures, id: \.type) { creature in
                HStack {
                    Image("\(creature.type.lowercased())_\(creature.state.lowercased())")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())

                    Text(creature.type.capitalized)
                        .font(.title2)
                        .fontWeight(.medium)

                    Spacer()

                    if selectedCreature?.type == creature.type {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(selectedCreature?.type == creature.type ? Color.purple.opacity(0.2) : Color.clear)
                .cornerRadius(10)
                .onTapGesture {
                    selectCreature(creature: creature)
                }
            }
            .padding()

            if let selectedCreature = selectedCreature {
                Button("Confirm Selection") {
                    saveSelectedCreature(creature: selectedCreature)
                    showHatchPetView = true
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding()
                .sheet(isPresented: $showHatchPetView) {
                    HatchPetView(onHatchComplete: {
                        dismiss() // Dismiss SelectCreatureView after hatching
                    }).environmentObject(userViewModel)
                }
            }
        }
    }

    private func selectCreature(creature: PredefinedCreature) {
        selectedCreature = creature
    }

    private func saveSelectedCreature(creature: PredefinedCreature) {
        guard let user = userViewModel.currentUser else { return }

        let newCreature = Creature(type: creature.type, name: creature.name, state: creature.state, user: user)
        user.creature = newCreature

        do {
            try modelContext.save()
            print("Creature saved successfully.")
        } catch {
            print("Error saving creature: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SelectCreatureView(userViewModel: UserViewModel( ))
}
