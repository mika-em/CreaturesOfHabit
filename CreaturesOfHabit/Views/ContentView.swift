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
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var navigationManager = NavigationManager() // Add NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) { // Bind to NavigationManager's path
            if userViewModel.isAuthenticated {
                if let creature = userViewModel.currentUser?.creature {
                    MainTabView()
                        .environmentObject(userViewModel)
                        .onAppear {
                            navigationManager.reset() // Reset the navigation stack
                        }
                } else {
                    AuthenticatedView() // Handles onboarding
                        .environmentObject(userViewModel)
                        .environmentObject(navigationManager)
                }
            } else {
                AuthenticationView(onLogin: {
                    userViewModel.fetchLoggedInUser(modelContext: modelContext)
                })
                .environmentObject(userViewModel)
            }
        }
        .onAppear {
            userViewModel.fetchLoggedInUser(modelContext: modelContext)
        }
        .environmentObject(navigationManager) // Provide NavigationManager to child views
    }
}

#Preview {
    ContentView()
}
