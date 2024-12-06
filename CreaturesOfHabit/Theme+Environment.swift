//
//  Theme+Environment.swift
//  CreaturesOfHabit
//
//  Created by Mika M on 2024-12-05.
//  Integrates Theme into the SwiftUI environment by allowing global access to the theme.

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
