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
    
    var body: some View {
        Group {
            if userViewModel.isAuthenticated {
                CreatureStatsView()
                    .environment(\.modelContext, modelContext)
                    .environmentObject(userViewModel) // Pass the UserViewModel
            } else {
                LandingPageView()
                    .environment(\.modelContext, modelContext)
                    .environmentObject(userViewModel) // Pass the UserViewModel
            }
        }
        .onAppear {
            userViewModel.fetchLoggedInUser(modelContext: modelContext)
        }
    }
}

#Preview {
    ContentView()
}
