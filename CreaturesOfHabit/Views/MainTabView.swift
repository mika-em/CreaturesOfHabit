//
//  MainTabView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-05.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        Group {
            if let currentUser = userViewModel.currentUser {
                TabView {
                    CreatureStatsView(viewModel: CreatureStatsViewModel(
                        creature: currentUser.creature ?? PreviewData.mockCreature,
                        user: currentUser
                    ))
                    .tabItem {
                        Label("Creature", systemImage: "pawprint")
                    }

                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                }
                .environment(\.modelContext, modelContext)
                .environmentObject(userViewModel) // Redundant but safe
            } else {
                // Redirect to LandingPageView if the user is logged out
                LandingPageView()
                    .environment(\.modelContext, modelContext)
                    .environmentObject(userViewModel)
            }
        }
        .onAppear {
            print("MainTabView loaded with userViewModel: \(userViewModel)")
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(UserViewModel())
}
