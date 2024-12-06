//
//  LandingPageView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import Foundation
import SwiftUI

struct LandingPageView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var userViewModel = UserViewModel()
    @Environment(\.theme) private var theme
    
    var onLogin: (() -> Void)? // Optional callback for login success
    
    var body: some View {
        ZStack {
                        LinearGradient(
                            gradient: theme.gradients.defaultGradient,
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
            Group {
                if userViewModel.isAuthenticated {
                    if let creature = userViewModel.currentUser?.creature {
                        // User has a creature
                        VStack(spacing: 20) {
                            //                        Image(systemName: "heart.fill")
                            //                            .resizable()
                            //                            .foregroundColor(Color.purple)
                            //                            .frame(width: 120, height: 120)
                            
                            Text("Welcome to \nCreatures of Habit")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("Build healthy habits and watch your creature grow!")
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .padding()
                            
                            NavigationLink(
                                destination: CreatureStatsView(viewModel: CreatureStatsViewModel(creature: creature, user: userViewModel.currentUser!))
                            ) {
                                Text("Check on your pet")
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                            
                            NavigationLink(destination: AboutView()) {
                                Text("Learn More")
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                            
                            Button(action: {
                                userViewModel.logout(modelContext: modelContext)
                            }) {
                                Text("Logout")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                if let creature = userViewModel.currentUser?.creature {
                                    userViewModel.deleteUserCreature(modelContext: modelContext, creature: creature)
                                }
                            }) {
                                Text("Wipe Creature")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    } else {
                        // User does not have a creature
                        VStack(spacing: 20) {
                            //                        Image(systemName: "heart.fill")
                            //                            .resizable()
                            //                            .foregroundColor(Color.purple)
                            //                            .frame(width: 120, height: 120)
                            
                            Text("Welcome to \nCreatures of Habit")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("Build healthy habits and watch your creature grow!")
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .padding()
                            
                            NavigationLink(
                                destination: SelectCreatureView(userViewModel: userViewModel)
                            ) {
                                Text("Start your journey")
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                            
                            NavigationLink(destination: AboutView()) {
                                Text("Learn More")
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                            
                            Button(action: {
                                userViewModel.logout(modelContext: modelContext)
                            }) {
                                Text("Logout")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                } else {
                    // Login/Register flow
                    VStack(spacing: 20) {
                        LoginView(userViewModel: userViewModel, onLogin: onLogin)
                        NavigationLink(destination: RegisterView(userViewModel: userViewModel)) {
                            Text("Don't have an account? Create One!")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .onAppear {
                userViewModel.fetchLoggedInUser(modelContext: modelContext)
                if userViewModel.isAuthenticated {
                    onLogin?() // Automatically move to root if logged in
                }
            }
        }
    }
}
#Preview {
    LandingPageView()
}
