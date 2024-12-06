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
    @State private var navigateToDevView = false
    
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
                
                NavigationStack {
                    VStack {
                        Button("Go to Dev View") {
                            navigateToDevView = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .navigationDestination(isPresented: $navigateToDevView) {
                        DevView(devViewModel: DevViewModel(creature: (userViewModel.currentUser?.creature)!, modelContext: modelContext))
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let mockViewModel = UserViewModel()
    mockViewModel.currentUser = PreviewData.mockUser

    return ProfileView()
        .environmentObject(mockViewModel)
}
