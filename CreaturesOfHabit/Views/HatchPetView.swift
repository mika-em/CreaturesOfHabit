//
//  HatchPetView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import Foundation
import SwiftUI

struct HatchPetView: View {
    @State private var isHatched = false
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    let onHatchComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            if let creature = userViewModel.currentUser?.creature {
                if isHatched {
                    AnimatedImageView(
                        firstImageName: "\(creature.type.lowercased())_\(creature.state.lowercased())",
                        secondImageName: "\(creature.type.lowercased())_\(creature.state.lowercased())2",
                        animationDuration: Constants.creatureAnimDuration
                    )
                    .frame(width: 200, height: 200)
                    .padding()
                    
                    Text("You hatched a \(creature.type)!")
                        .font(.title3)
                        .fontWeight(.bold)
                } else {
                    Spacer()
                    Image("egg")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding(.top, 70)
                    
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isHatched = true
                        }
                    }) {
                        Text("Tap to Hatch Your Creature!")
                            .fontWeight(.bold)
                            .font(.subheadline)
                            .padding(15)
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 100)
                }
                
                if isHatched {
                    Button(action: {
                        dismiss()
                        onHatchComplete()
                    }) {
                        Text("Continue")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                }
            } else {
                Text("No creature selected!")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    HatchPetView(onHatchComplete: {
        print("Hatch complete in preview!")
    })
    .environmentObject(UserViewModel())
    .environmentObject(NavigationManager())
}
