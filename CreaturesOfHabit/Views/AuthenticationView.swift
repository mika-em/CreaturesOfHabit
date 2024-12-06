//
//  AuthenticationView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-05.
//

import SwiftUI

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.modelContext) private var modelContext
    var onLogin: (() -> Void)? // Optional login callback
    
    var body: some View {
        VStack(spacing: 20) {
            LoginView(userViewModel: userViewModel, onLogin: onLogin)
            NavigationLink(destination: RegisterView(userViewModel: userViewModel)) {
                Text("Don't have an account? Create One!")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    AuthenticationView().environmentObject(UserViewModel())
}
