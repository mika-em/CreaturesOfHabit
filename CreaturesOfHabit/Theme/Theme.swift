//
//  Theme.swift
//  CreaturesOfHabit
//
//  Created by Mika M on 2024-12-05.
//

import Foundation
import SwiftUI
import UIKit

struct Theme {
    struct Colors {
        let gradientStart = UIColor(red: 0.72, green: 0.85, blue: 1.0, alpha: 1.0)
        let gradientMiddle = UIColor(red: 0.85, green: 0.80, blue: 1.0, alpha: 1.0)
        let gradientEnd = UIColor(red: 0.94, green: 0.78, blue: 1.0, alpha: 1.0)
        let primaryText = UIColor.darkGray
        let secondaryText = UIColor.gray

        let primaryButtonBackground = UIColor.purple
        let primaryButtonForeground = UIColor.white
        let disabledButtonBackground = UIColor.lightGray
        let disabledButtonForeground = UIColor.darkGray
    }

    struct Gradients {
        let defaultGradient = Gradient(colors: [
            Color(UIColor(red: 0.72, green: 0.85, blue: 1.0, alpha: 1.0)),
            Color(UIColor(red: 0.85, green: 0.80, blue: 1.0, alpha: 1.0)),
            Color(UIColor(red: 0.94, green: 0.78, blue: 1.0, alpha: 1.0)),
        ])

        let alternateGradient = Gradient(colors: [
            Color(UIColor(red: 0.8, green: 0.6, blue: 1.0, alpha: 1.0)),
            Color(UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)),
        ])
    }

    struct Fonts {
        let headerFont = UIFont.systemFont(ofSize: 36, weight: .bold)
        let bodyFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        let buttonFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    }

    struct Buttons {
        let buttonHeight: CGFloat = 33
        let cornerRadius: CGFloat = 10
    }

    let colors: Colors
    let fonts: Fonts
    let buttons: Buttons
    let gradients: Gradients
}

enum ThemeManager {
    static let shared = Theme(
        colors: Theme.Colors(),
        fonts: Theme.Fonts(),
        buttons: Theme.Buttons(),
        gradients: Theme.Gradients()
    )
}

struct GradientBackgroundModifier: ViewModifier {
    var gradient: Gradient

    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: gradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            content
        }
    }
}

extension View {
    func applyGradient(_ gradient: Gradient) -> some View {
        modifier(GradientBackgroundModifier(gradient: gradient))
    }
}

struct GradientPreview: View {
    @Environment(\.theme) private var theme

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(theme.colors.gradientStart),
                    Color(theme.colors.gradientMiddle),
                    Color(theme.colors.gradientEnd),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )

            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Test Header Font")
                    .font(Font(theme.fonts.headerFont))
                    .foregroundColor(Color(theme.colors.primaryText))
                Text("Test Body Font")
                    .font(Font(theme.fonts.bodyFont))
                    .foregroundColor(Color(theme.colors.secondaryText))
            }
        }
    }
}

#Preview {
    GradientPreview()
        .environment(\.theme, ThemeManager.shared)
}
