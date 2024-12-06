//
//  ThemeEnvironment.swift
//  CreaturesOfHabit
//
// 
//  Created by Mika M on 2024-12-05.
//

import Foundation
import SwiftUI

struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = ThemeManager.shared
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
