//
//  LandingPageView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//


import SwiftUI
import Foundation

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .foregroundColor(Color.purple)
                    .frame(width: 120, height: 120)
                
                Text("Welcome to \nCreatures of Habit")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                Text("Build healthy habits and watch your creature grow!")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .padding()
                
                NavigationLink(destination: HatchPetView()) {
                    Text("Start your journey")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
                NavigationLink(destination: AboutView()){
                    Text("Learn More")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
            }
        }
        .padding()
    }
}


#Preview {
    LandingPageView()
}
