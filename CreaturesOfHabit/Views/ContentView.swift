//
//  ContentView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) private var theme
    @Environment(\.theme) private var theme
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var navigationManager = NavigationManager() // Add NavigationManager

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            NavigationStack(path: $navigationManager.path) { // Bind to NavigationManager's path
                if userViewModel.isAuthenticated {
                    if let creature = userViewModel.currentUser?.creature {
                        MainTabView()
                            .environmentObject(userViewModel)
                            .onAppear {
                                navigationManager.reset() // Reset the navigation stack
                            }
                    } else {
                        AuthenticatedView()
                            .environmentObject(userViewModel)
                    }
                } else {
                    AuthenticationView(onLogin: {
                        userViewModel.fetchLoggedInUser(modelContext: modelContext)
                    })
                    .environmentObject(userViewModel)
                }
            }
        }
        .onAppear {
            userViewModel.fetchLoggedInUser(modelContext: modelContext)
        }
        .environmentObject(navigationManager)
    }
}


#Preview {
    ContentView()
}
