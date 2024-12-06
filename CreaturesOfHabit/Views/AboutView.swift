//
//  AboutView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import Foundation
import SwiftUI

let teamMembers = ["Alfrey", "Ben", "Cheryl", "Conrad", "Mika"]

struct AboutView: View {
    @Environment(\.theme) private var theme

    var body: some View {
        ZStack {
      
            LinearGradient(
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 20) {
                    // Title
                    Text("About the App")
                        .font(Font(theme.fonts.headerFont)) // Use header font from theme
                        .foregroundColor(Color(theme.colors.primaryText)) // Use theme color
                        .padding(.top)

                    // Description
                    Text("Creatures of Comfort helps you build healthy habits by caring for a pet. Build your habits and help your pet thrive!")
                        .font(Font(theme.fonts.bodyFont)) // Use body font from theme
                        .foregroundColor(Color(theme.colors.secondaryText)) // Use secondary text color
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)

                    // Start Journey Button
                    NavigationLink(destination: HatchPetView()) {
                        Text("Start your journey!")
                            .font(Font(theme.fonts.buttonFont)) // Use button font from theme
                    }
                    .buttonStyle(ThemedButtonStyle(
                        backgroundColor: Color(theme.colors.primaryButtonBackground) // Primary button background
                    ))
                    .padding(.top, 20)
                }

                Spacer()

                // Credits Button
                NavigationLink(destination: CreditsView()) {
                    Text("Credits")
                        .font(Font(theme.fonts.bodyFont))
                        .foregroundColor(Color(theme.colors.tertiaryButtonBackground))
                        .bold()
                }
                .padding(.bottom, 30)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    AboutView()
        .environment(\.theme, ThemeManager.shared) // Inject the theme environment for preview
}
