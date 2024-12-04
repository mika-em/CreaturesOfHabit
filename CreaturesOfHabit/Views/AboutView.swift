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
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                Text("About the App")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)

                Text("Creatures of Comfort helps you build healthy habits by caring for a pet. Build your habits and help your pet thrive!")
                    .font(.body)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)

                NavigationLink(destination: HatchPetView()) {
                    Text("Start your journey!")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .fontWeight(.bold)

                }.padding(.top, 20)
            }
            Spacer()
            NavigationLink(destination: CreditsView()) {
                Text("Credits")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)

            }.padding(.bottom, 30)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    AboutView()
}
