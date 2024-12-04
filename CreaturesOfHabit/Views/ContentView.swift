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

    var body: some View {
        LandingPageView()
            .onAppear {
                DataSeeder.seedHabits(modelContext: modelContext)
            }
            .padding()
    }
}

#Preview {
    ContentView()
}
