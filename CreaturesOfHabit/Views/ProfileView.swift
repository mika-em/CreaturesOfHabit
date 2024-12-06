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
                 
                 Text("Profile")
                     .font(Font(theme.fonts.headerFont))
                     .fontWeight(.bold)
                     .foregroundColor(Color(theme.colors.primaryText))
                 
                 Button(action: {
                     userViewModel.logout(modelContext: modelContext)
                 }) {
                     Text("Logout")
                         .font(Font(theme.fonts.buttonFont))
                         .padding()
                         .background(Color.red)
                         .foregroundColor(.white)
                         .cornerRadius(theme.buttons.cornerRadius)
                 }
                 
                 if let creature = userViewModel.currentUser?.creature {
                     Button(action: {
                         userViewModel.deleteUserCreature(modelContext: modelContext, creature: creature)
                     }) {
                         Text("Wipe Creature")
                             .font(Font(theme.fonts.buttonFont))
                             .padding()
                             .background(Color.red)
                             .foregroundColor(.white)
                             .cornerRadius(theme.buttons.cornerRadius)
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
             .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
         }
     }
 }

 #Preview {
     ProfileView().environmentObject(UserViewModel())
         .environment(\.theme, ThemeManager.shared)
 }
