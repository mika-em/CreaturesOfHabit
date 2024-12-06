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
    @StateObject private var userViewModel = UserViewModel()

    var body: some View {
        Group {
            if userViewModel.isAuthenticated {
                NavigationStack {
                    MainTabView()
                        .environmentObject(userViewModel)
                        .applyGradient(theme.gradients.defaultGradient)
                }
            } else {
                NavigationStack {
                    LandingPageView()
                        .environment(\.modelContext, modelContext)
                        .environmentObject(userViewModel)
                        .applyGradient(theme.gradients.defaultGradient)
                }
            }
        }
        .onAppear {
            userViewModel.fetchLoggedInUser(modelContext: modelContext)
        }
        .applyGradient(theme.gradients.defaultGradient)
    }
}


#Preview {
    ContentView()
}
