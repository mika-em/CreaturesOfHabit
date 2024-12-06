//
//  CreditsView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//

import Foundation
import SwiftUI

struct CreditsView: View {
    let teamMembers = ["Alfrey", "Ben", "Cheryl", "Conrad", "Mika"]
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
                Spacer()
                Text("Team Members")
                    .font(Font(theme.fonts.headerFont))
                   .fontWeight(.bold)
                   .foregroundColor(Color(theme.colors.primaryText))
                   .padding(.top, 30)

                VStack(spacing: 10) {
                    ForEach(teamMembers, id: \.self) {
                        member in Text(member)
                            .font(Font(theme.fonts.bodyFont))
                                                      .foregroundColor(Color(theme.colors.secondaryText))
                    }
                }.padding(.horizontal)
                Spacer()
            }
            .padding()
           .frame(maxWidth: .infinity, alignment: .center)
    }
    }
}

#Preview {
    CreditsView()
        .environment(\.theme, ThemeManager.shared)
}
