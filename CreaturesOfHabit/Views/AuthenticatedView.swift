//
//  AuthenticatedView.swift
//  CreaturesOfHabit
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
            LinearGradient(
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 20) {
                if let creature = userViewModel.currentUser?.creature {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundColor(Color.purple)
                        .frame(width: 120, height: 120)
                    
                    Text("Welcome to \nCreatures of Habit")
                        .font(Font(theme.fonts.headerFont))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(theme.colors.primaryText))
                        .padding()

                    Text("Build healthy habits and watch your creature grow!")
                        .font(Font(theme.fonts.bodyFont))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(theme.colors.secondaryText))
                        .padding()

                    NavigationLink(
                        destination: CreatureStatsView(viewModel: CreatureStatsViewModel(
                            creature: creature,
                            user: userViewModel.currentUser!,
                            modelContext: modelContext
                        ))
                    ) {
                        Text("Check on your pet")
                            .padding()
                            .background(Color(theme.colors.primaryButtonBackground))
                            .foregroundColor(.white)
                            .cornerRadius(theme.buttons.cornerRadius)
                    }
                    .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.primaryButtonBackground)))

                    NavigationLink(destination: AboutView()) {
                        Text("Learn More")
                            .padding()
                            .background(Color(theme.colors.secondaryButtonBackground))
                            .foregroundColor(.white)
                            .cornerRadius(theme.buttons.cornerRadius)
                    }
                    .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.secondaryButtonBackground)))

                    Button(action: {
                        userViewModel.logout(modelContext: modelContext)
                    }) {
                        Text("Logout")
                            .font(Font(theme.fonts.bodyFont))
                            .foregroundColor(Color.red)
                    }
                    Button(action: {
                        if let creature = userViewModel.currentUser?.creature {
                            userViewModel.deleteUserCreature(modelContext: modelContext, creature: creature)
                        }
                    }) {
                        Text("Wipe Creature")
                            .font(Font(theme.fonts.bodyFont))
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(theme.buttons.cornerRadius)
                    }
                    .buttonStyle(ThemedButtonStyle(backgroundColor: Color.red))
                } else {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundColor(Color.purple)
                        .frame(width: 120, height: 120)

                    Text("Welcome to \nCreatures of Habit")
                        .font(Font(theme.fonts.headerFont))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(theme.colors.primaryText))
                        .padding()

                    Text("Build healthy habits and watch your creature grow!")
                        .font(Font(theme.fonts.bodyFont))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(theme.colors.secondaryText))
                        .padding()

                    NavigationLink(destination: SelectCreatureView(userViewModel: userViewModel)) {
                        Text("Start your journey")
                            .padding()
                            .background(Color(theme.colors.primaryButtonBackground))
                            .foregroundColor(.white)
                            .cornerRadius(theme.buttons.cornerRadius)
                    }
                    .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.primaryButtonBackground)))

                    NavigationLink(destination: AboutView()) {
                        Text("Learn More")
                            .padding()
                            .background(Color(theme.colors.secondaryButtonBackground))
                            .foregroundColor(.white)
                            .cornerRadius(theme.buttons.cornerRadius)
                    }
                    .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.secondaryButtonBackground)))

                    Button(action: {
                        userViewModel.logout(modelContext: modelContext)
                    }) {
                        Text("Logout")
                            .font(Font(theme.fonts.bodyFont))
                            .foregroundColor(Color.red)
                    }.padding(.top, 60)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    AuthenticatedView()
        .environmentObject(UserViewModel())
        .environment(\.theme, ThemeManager.shared)
}
