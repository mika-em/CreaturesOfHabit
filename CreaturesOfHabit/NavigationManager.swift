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
    
    func reset() {
        path = NavigationPath()
    }
    
    func resetWithDismiss(dismissAction: @escaping () -> Void) {
        let dismissCount = path.count
        path = NavigationPath() // Clear the navigation path
        
        // Sequentially dismiss views
        for _ in 0..<dismissCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Small delay to ensure smooth dismissals
                dismissAction()
            }
        }
    }
}
