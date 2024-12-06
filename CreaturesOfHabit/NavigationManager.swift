//
//  NavigationManager.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-05.
//

import Foundation
import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    @Published var onboardingComplete = false // Track onboarding state

    func reset() {
        path = NavigationPath()
    }

    func completeOnboarding() {
        onboardingComplete = true
        reset()
    }
}
