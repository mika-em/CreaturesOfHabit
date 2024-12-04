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

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Team Members")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 30)

            VStack(spacing: 10) {
                ForEach(teamMembers, id: \.self) {
                    member in Text(member)
                        .font(.body)
                }
            }.padding(.horizontal)
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    CreditsView()
}
