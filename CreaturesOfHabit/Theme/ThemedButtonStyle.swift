//
//  ThemedButtonStyle.swift
//  CreaturesOfHabit
//
//  Created by Mika M on 2024-12-05.
//

import SwiftUI

struct ThemedButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(theme.fonts.buttonFont))
            .frame(height: theme.buttons.buttonHeight)
            .padding(.horizontal, 20)
            .background(
                configuration.isPressed
                    ? Color(theme.colors.primaryButtonBackground).opacity(0.8)
                    : Color(theme.colors.primaryButtonBackground)
            )
            .foregroundColor(Color(theme.colors.primaryButtonForeground))
            .cornerRadius(theme.buttons.cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
