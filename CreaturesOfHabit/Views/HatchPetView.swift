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
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.dismiss) private var dismiss
    let onHatchComplete: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            if isHatched {
                Image("slime")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.orange)
                    .padding()

                Text("You hatched a slime!")
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
                        isHatched.toggle()
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
                    dismiss() // Close the modal
                    onHatchComplete() // Notify SelectCreatureView
                }) {
                    Text("Continue")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
            }
        }
    }
}

#Preview {
    HatchPetView(onHatchComplete: {
        print("Hatch complete in preview!")
    })
    .environmentObject(UserViewModel())
    .environmentObject(NavigationManager())
}
