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
        let primaryText = UIColor.darkText
        let secondaryText = UIColor.darkGray

        let primaryButtonBackground = UIColor(red: 0.7, green: 0.5, blue: 0.9, alpha: 1.0)
        let secondaryButtonBackground = UIColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0)
        let tertiaryButtonBackground = UIColor(red: 0.6, green: 0.75, blue: 0.85, alpha: 1.0)
        let logoutButtonBackground = UIColor.red
        let primaryButtonForeground = UIColor.white
    }

    struct Gradients {
        let defaultGradient: Gradient
        let alternateGradient: Gradient

        init(colors: Colors) {
            self.defaultGradient = Gradient(colors: [
                Color(colors.gradientStart),
                Color(colors.gradientMiddle),
                Color(colors.gradientEnd)
            ])

            self.alternateGradient = Gradient(colors: [
                Color(UIColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0)),
                Color(UIColor(red: 0.8, green: 0.7, blue: 0.9, alpha: 1.0))
            ])
        }
    }

    struct Fonts {
        let headerFont = UIFont.systemFont(ofSize: 36, weight: .bold)
        let bodyFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        let buttonFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    }


    struct Buttons {
        let buttonHeight: CGFloat = 44
        let cornerRadius: CGFloat = 8
    }

    let colors: Colors = Colors()
    let fonts: Fonts = Fonts()
    let buttons: Buttons = Buttons()
    let gradients: Gradients

    init() {
        self.gradients = Gradients(colors: colors)
    }
}

enum ThemeManager {
    static let shared = Theme()
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
                gradient: theme.gradients.defaultGradient,
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
