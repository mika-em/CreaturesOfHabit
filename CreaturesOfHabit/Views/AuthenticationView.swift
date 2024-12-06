//
//  AuthenticationView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-05.
//

import SwiftUI

import SwiftUI

struct AuthenticationView: View {
    @Environment(\.theme) private var theme
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.modelContext) private var modelContext
    var onLogin: (() -> Void)? // Optional login callback

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                LoginView(userViewModel: userViewModel, onLogin: onLogin)
                NavigationLink(destination: RegisterView(userViewModel: userViewModel)) {
                    Text("Don't have an account? Create One!")
                        .foregroundColor(Color.purple)
                        .font(Font(theme.fonts.bodyFont))
                        .bold()
                        .padding()
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AuthenticationView()
}
