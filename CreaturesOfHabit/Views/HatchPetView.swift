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
    @EnvironmentObject var navigationManager: NavigationManager


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
    }

    private func setMainTabViewAsRoot(with userViewModel: UserViewModel) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first
        else {
            print("Unable to access UIWindow")
            return
        }

        // Ensure userViewModel is valid
        guard userViewModel.currentUser != nil else {
            print("UserViewModel missing currentUser")
            return
        }

        let rootView = MainTabView()
            .environmentObject(userViewModel)

        DispatchQueue.main.async {
            window.rootViewController = UIHostingController(rootView: rootView)
            window.makeKeyAndVisible()
            print("RootViewController set with userViewModel: \(userViewModel)")
        }
    }

    private func setMainTabViewAsRoot(with userViewModel: UserViewModel) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first
        else {
            print("Unable to access UIWindow")
            return
        }

        // Ensure userViewModel is valid
        guard userViewModel.currentUser != nil else {
            print("UserViewModel missing currentUser")
            return
        }

        let rootView = MainTabView()
            .environmentObject(userViewModel)

        DispatchQueue.main.async {
            window.rootViewController = UIHostingController(rootView: rootView)
            window.makeKeyAndVisible()
            print("RootViewController set with userViewModel: \(userViewModel)")
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
