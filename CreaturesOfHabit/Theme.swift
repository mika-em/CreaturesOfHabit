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
    }

    struct Gradients {
        let defaultGradient = Gradient(colors: [
            Color(UIColor(red: 0.72, green: 0.85, blue: 1.0, alpha: 1.0)),
            Color(UIColor(red: 0.85, green: 0.80, blue: 1.0, alpha: 1.0)),
            Color(UIColor(red: 0.94, green: 0.78, blue: 1.0, alpha: 1.0))
        ])

        let alternateGradient = Gradient(colors: [
            Color(UIColor(red: 0.8, green: 0.6, blue: 1.0, alpha: 1.0)),
            Color(UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0))
        ])
    }

    struct Fonts {
        let headerFont = UIFont.systemFont(ofSize: 33, weight: .bold)
        let bodyFont = UIFont.systemFont(ofSize: 22, weight: .medium)
    }

    struct TextStyles {
        let header = Font(UIFont.systemFont(ofSize: 33, weight: .bold))
        let body = Font(UIFont.systemFont(ofSize: 22, weight: .medium))
    }

    struct Backgrounds {
        let dragonBackground = UIImage(named: "dragon_background")
        let slimeBackground = UIImage(named: "slime_background")
        let chocoboBackground = UIImage(named: "chocobo_background")
    }

    let colors: Colors
    let fonts: Fonts
    let textStyles: TextStyles
    let gradients: Gradients
    let backgrounds: Backgrounds
}

enum ThemeManager {
    static let shared = Theme(
        colors: Theme.Colors(),
        fonts: Theme.Fonts(),
        textStyles: Theme.TextStyles(),
        gradients: Theme.Gradients(),
        backgrounds: Theme.Backgrounds()
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
