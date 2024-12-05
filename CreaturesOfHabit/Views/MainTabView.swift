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
        TabView {
            CreatureStatsView()
                .tabItem {
                    Label("Creature", systemImage: "pawprint")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .environment(\.modelContext, modelContext)
        .environmentObject(userViewModel)
    }
}

#Preview {
    MainTabView()
}
