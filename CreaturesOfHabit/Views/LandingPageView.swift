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
            // Background gradient
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
                            Image(systemName: "heart.fill")
                                .resizable()
                                .foregroundColor(Color.purple)
                                .frame(width: 120, height: 120)
                            
                            Text("Welcome to \nCreatures of Habit")
                                .font(Font(theme.fonts.headerFont))
                                .fontWeight(.medium)
                                .foregroundColor(Color(theme.colors.primaryText))
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("Build healthy habits and watch your creature grow!")
                                .font(Font(theme.fonts.bodyFont))
                                .foregroundColor(Color(theme.colors.secondaryText))
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .padding()
                            
                            NavigationLink(
                                destination: CreatureStatsView(viewModel: CreatureStatsViewModel(creature: creature, user: userViewModel.currentUser!, modelContext: modelContext))
                            ) {
                                Text("Check on your pet")
                                    .padding()
                                    .background(Color(theme.colors.secondaryButtonBackground))
                                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                                    .cornerRadius(theme.buttons.cornerRadius)
                            }
                            
                            NavigationLink(destination: AboutView()) {
                                Text("Learn More")
                                    .padding()
                                    .background(Color(theme.colors.secondaryButtonBackground))
                                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                                    .cornerRadius(theme.buttons.cornerRadius)
                            }
                            
                            Button(action: {
                                userViewModel.logout(modelContext: modelContext)
                            }) {
                                Text("Logout")
                                    .font(Font(theme.fonts.bodyFont))
                                    .padding()
                                    .background(Color(theme.colors.logoutButtonBackground))
                                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                                    .cornerRadius(theme.buttons.cornerRadius)
                            }
                            
                            Button(action: {
                                if let creature = userViewModel.currentUser?.creature {
                                    userViewModel.deleteUserCreature(modelContext: modelContext, creature: creature)
                                }
                            }) {
                                Text("Wipe Creature")
                                    .font(Font(theme.fonts.bodyFont))
                                    .padding()
                                    .background(Color(theme.colors.logoutButtonBackground))
                                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                                    .cornerRadius(theme.buttons.cornerRadius)
                            }
                        }
                    } else {
                        // User does not have a creature
                        VStack(spacing: 20) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .foregroundColor(Color.purple)
                                .frame(width: 120, height: 120)
                            
                            Text("Welcome to \nCreatures of Habit")
                                .font(Font(theme.fonts.headerFont))
                                .fontWeight(.medium)
                                .foregroundColor(Color(theme.colors.primaryText))
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("Build healthy habits and watch your creature grow!")
                                .font(Font(theme.fonts.bodyFont))
                                .foregroundColor(Color(theme.colors.secondaryText))
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .padding()
                            
                            NavigationLink(
                                destination: SelectCreatureView(userViewModel: userViewModel)
                            ) {
                                Text("Start your journey")
                                    .padding()
                                    .background(Color(theme.colors.primaryButtonBackground))
                                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                                    .cornerRadius(theme.buttons.cornerRadius)
                            }
                            
                            NavigationLink(destination: AboutView()) {
                                Text("Learn More")
                                    .padding()
                                    .background(Color(theme.colors.secondaryButtonBackground))
                                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                                    .cornerRadius(theme.buttons.cornerRadius)
                            }
                            
                            Button(action: {
                                userViewModel.logout(modelContext: modelContext)
                            }) {
                                Text("Logout")
                                    .font(Font(theme.fonts.bodyFont))
                                    .padding()
                                    .background(Color(theme.colors.logoutButtonBackground))
                                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                                    .cornerRadius(theme.buttons.cornerRadius)
                            }
                        }
                    }
                } else {
                    // Login/Register flow
                    VStack(spacing: 20) {
                        LoginView(userViewModel: userViewModel, onLogin: onLogin)
                            .padding(.horizontal, 30)
                        NavigationLink(destination: RegisterView(userViewModel: userViewModel)) {
                            Text("Don't have an account? Create One!")
                                .font(Font(theme.fonts.bodyFont))
                                .foregroundColor(Color(theme.colors.secondaryText))
                                .padding()
                        }
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

#Preview {
    LandingPageView()
        .environment(\.theme, ThemeManager.shared)
}
