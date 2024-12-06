//
//  AuthenticatedView.swift
//  Creatures of Habit
//
//  Created by Benny Li on 2024-12-05.
//

import SwiftUI

struct AuthenticatedView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) private var theme // Inject the theme environment

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if let creature = userViewModel.currentUser?.creature {
                authenticatedContent(creature: creature)
            } else {
                nonAuthenticatedContent()
            }
        }
    }

    // Content for Authenticated Users
    private func authenticatedContent(creature: Creature) -> some View {
        VStack(spacing: 20) {
            Spacer() .frame(height: 250)
  
            Text("Welcome to \nCreatures of Habit")
                .font(Font(theme.fonts.headerFont))
                .foregroundColor(Color(theme.colors.primaryText))
                .multilineTextAlignment(.center)

            // Description
            Text("Build healthy habits and help your creature grow strong!")
                .font(Font(theme.fonts.bodyFont))
                .foregroundColor(Color(theme.colors.secondaryText))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            // Navigation Buttons
            VStack(spacing: 15) {
                NavigationLink(
                    destination: CreatureStatsView(viewModel: CreatureStatsViewModel(
                        creature: creature,
                        user: userViewModel.currentUser!
                    ))
                ) {
                    Text("Check on your Pet")
                }
                .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.primaryButtonBackground)))

                NavigationLink(destination: AboutView()) {
                    Text("Learn More")
                }
                .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.secondaryButtonBackground)))
            }
            .frame(maxWidth: .infinity)

            Spacer()

            // Footer Logout Button
            Button(action: {
                userViewModel.logout(modelContext: modelContext)
            }) {
                Text("Logout")
                    .font(Font(theme.fonts.bodyFont))
                    .foregroundColor(Color.red)
            }
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }

    // Content for Non-Authenticated Users
    private func nonAuthenticatedContent() -> some View {
        VStack(spacing: 20) {
            Spacer()
                        .frame(height: 250)

            // Welcome Message
            Text("Welcome to \nCreatures of Habit")
                .font(Font(theme.fonts.headerFont))
                .foregroundColor(Color(theme.colors.primaryText))
                .multilineTextAlignment(.center)

            // Description
            Text("Start building habits today and adopt a new creature!")
                .font(Font(theme.fonts.bodyFont))
                .foregroundColor(Color(theme.colors.secondaryText))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            // Navigation Buttons
            VStack(spacing: 15) {
                NavigationLink(destination: SelectCreatureView(userViewModel: userViewModel)) {
                    Text("Start Your Journey")
                }
                .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.primaryButtonBackground)))

                NavigationLink(destination: AboutView()) {
                    Text("Learn More")
                }
                .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.tertiaryButtonBackground)))
            }
            .frame(maxWidth: .infinity)

            Spacer()

            // Footer Logout Button
            Button(action: {
                userViewModel.logout(modelContext: modelContext)
            }) {
                Text("Logout")
                    .font(Font(theme.fonts.bodyFont))
                    .foregroundColor(Color.red)
            }
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let mockUserViewModel = UserViewModel()
    return AuthenticatedView()
        .environmentObject(mockUserViewModel)
        .environment(\.theme, ThemeManager.shared)
}
