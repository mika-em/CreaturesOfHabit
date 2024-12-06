//
//  AboutView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

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
                    Text("About the App")
                        .font(Font(theme.fonts.headerFont))
                        .fontWeight(.bold)
                        .foregroundColor(Color(theme.colors.primaryText))
                        .padding(.top)

                    Text("Creatures of Comfort helps you build healthy habits by caring for a pet. Build your habits and help your pet thrive!")
                        .font(Font(theme.fonts.bodyFont))
                        .foregroundColor(Color(theme.colors.secondaryText))
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                NavigationLink(destination: CreditsView()) {
                    Text("Credits")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(theme.colors.primaryText))
                        .padding()
                        .cornerRadius(theme.buttons.cornerRadius)
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
        .environment(\.theme, ThemeManager.shared)
}
