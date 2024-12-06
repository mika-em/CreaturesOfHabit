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
    @EnvironmentObject var userViewModel: UserViewModel  // Access the environment object
    @EnvironmentObject var navigationManager: NavigationManager
    
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
                    userViewModel.currentUser?.creature = Creature(type: "Slime", name: "Slimy", state: "Active", user: userViewModel.currentUser!)
                    navigationManager.reset() // Clear stack after creature creation
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
        .onAppear {
            // Add this debugging to confirm userViewModel exists in HatchPetView
            print("HatchPetView userViewModel before root switch: \(userViewModel)")
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
    HatchPetView()
}
