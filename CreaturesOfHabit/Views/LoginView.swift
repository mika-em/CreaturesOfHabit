//
//  LoginView.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-22.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var userViewModel: UserViewModel
    @State private var username = ""
    @State private var password = ""
    var onLogin: (() -> Void)? // Add the onLogin callback
    @Environment(\.theme) private var theme

    var body: some View {
//        ZStack {
//            LinearGradient(
//                gradient: theme.gradients.defaultGradient,
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea()

            VStack(spacing: 30) {
                // Header
                Text("Login")
                    .font(Font(theme.fonts.headerFont))
                    .foregroundColor(Color(theme.colors.primaryText))
                    .padding(.bottom, 10)

                // Login Form
                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(maxWidth: 300)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(maxWidth: 300) // Limit text field width

                    if let errorMessage = userViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.top, 5)
                    }

                    // Login Button
                    Button(action: {
                        userViewModel.login(username: username, password: password, modelContext: modelContext)
                        if userViewModel.isAuthenticated {
                            onLogin?()
                        }
                    }) {
                        Text("Login")
                    }
                    .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.primaryButtonBackground)))
                    .frame(maxWidth: 200)
                }
            }
        }
    }
//}
