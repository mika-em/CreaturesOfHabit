//
//  Utils.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-03.
//

import Foundation
import SwiftUI

enum Utils {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    static func resetStackAndNavigate(
        to destination: String,
        using navigationPath: inout NavigationPath
    ) {
        navigationPath = NavigationPath()  // Reset the stack
        navigationPath.append(destination) // Add the identifier to the stack
    }
}
