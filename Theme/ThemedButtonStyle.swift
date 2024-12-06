//
//  ThemedButtonStyle.swift
//  CreaturesOfHabit
//
//  Created by Mika M on 2024-12-06.
//


//
//  ThemedButtonStyle.swift
//  CreaturesOfHabit
//
//  Created by Mika M on 2024-12-05.
//

import SwiftUI

struct ThemedButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme
    var backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(theme.fonts.buttonFont))
            .frame(height: theme.buttons.buttonHeight)
            .padding(.horizontal, 20)
            .background(
                configuration.isPressed
                    ? backgroundColor.opacity(0.8)
                    : backgroundColor
            )
            .foregroundColor(Color(theme.colors.primaryButtonForeground)) // Text color
            .cornerRadius(theme.buttons.cornerRadius) // Rounded corners
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Press animation
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed) // Smooth animation
    }
}