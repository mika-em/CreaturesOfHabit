//
//  AuthenticatedView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-05.
//

import SwiftUI

import SwiftUI

struct AuthenticatedView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        if let creature = userViewModel.currentUser?.creature {
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
                
                NavigationLink(
                    destination: CreatureStatsView(viewModel: CreatureStatsViewModel(
                        creature: creature,
                        user: userViewModel.currentUser!,
                        modelContext: modelContext
                    ))
                ) {
                    Text("Check on your pet")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
                NavigationLink(destination: AboutView()) {
                    Text("Learn More")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    userViewModel.logout(modelContext: modelContext)
                }) {
                    Text("Logout")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    if let creature = userViewModel.currentUser?.creature {
                        userViewModel.deleteUserCreature(modelContext: modelContext, creature: creature)
                    }
                }) {
                    Text("Wipe Creature")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        } else {
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
                
                NavigationLink(destination: SelectCreatureView(userViewModel: userViewModel)) {
                    Text("Start your journey")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
                NavigationLink(destination: AboutView()) {
                    Text("Learn More")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    userViewModel.logout(modelContext: modelContext)
                }) {
                    Text("Logout")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    AuthenticatedView().environmentObject(UserViewModel())
}
