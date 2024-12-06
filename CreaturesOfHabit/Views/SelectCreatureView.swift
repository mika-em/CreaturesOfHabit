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
    @Environment(\.theme) private var theme

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing:15) {
                Spacer()
                Spacer()
                Text("Select your creature")
                    .font(Font(theme.fonts.headerFont))
                    .fontWeight(.bold)
                    .foregroundColor(Color(theme.colors.primaryText))
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
                                .foregroundColor(.purple)
                        }
                    }
                    .padding()
                    .background(selectedCreature?.type == creature.type ? Color.purple.opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                    .onTapGesture {
                        selectCreature(creature: creature)
                    }
                }
                .scrollContentBackground(.hidden)
                .padding()
                .background(Color.clear)
                
                if let selectedCreature = selectedCreature {
                    Button("Confirm Selection") {
                        saveSelectedCreature(creature: selectedCreature)
                        showHatchPetView = true
                    }
                    .padding()
                    .background(Color(theme.colors.primaryButtonBackground))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .sheet(isPresented: $showHatchPetView) {
                        HatchPetView(onHatchComplete: {
                            dismiss() // Dismiss SelectCreatureView after hatching
                        }).environmentObject(userViewModel)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
        }}
    
    
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
