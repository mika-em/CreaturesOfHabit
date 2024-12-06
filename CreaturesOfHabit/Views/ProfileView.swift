//
//  ProfileView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-05.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.modelContext) private var modelContext


    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)


            Button(action: {
                userViewModel.logout(modelContext: modelContext)
            }) {
                Text("Logout")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if let creature = userViewModel.currentUser?.creature {
                Button(action: {
                    userViewModel.deleteUserCreature(modelContext: modelContext, creature: creature)
                }) {
                    Text("Wipe Creature")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
