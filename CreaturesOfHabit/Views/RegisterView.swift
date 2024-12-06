//
//  RegisterView.swift
//  TEST
//
//  Created by Alfrey Chan on 2024-11-22.
//

import SwiftData
import SwiftUI

struct RegisterView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userViewModel: UserViewModel
    @StateObject private var registerViewModel = RegisterViewViewModel()
    @Environment(\.theme) private var theme

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: theme.gradients.alternateGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                VStack(spacing: 30) {
                    Text("Register")
                        .font(Font(theme.fonts.headerFont))
                        .foregroundColor(Color(theme.colors.primaryText))
                    VStack(spacing: 20) {
                        TextField("Username", text: $registerViewModel.username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .frame(maxWidth: 300)

                        SecureField("Password", text: $registerViewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textContentType(.newPassword) // Prevent autofill suggestions
                            .autocapitalization(.none) // Disable capitalization
                            .frame(maxWidth: 300)

                        SecureField("Confirm Password", text: $registerViewModel.confirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textContentType(.newPassword) // Prevent autofill suggestions
                            .autocapitalization(.none)
                            .frame(maxWidth: 300) // Disable capitalization

                        if registerViewModel.showError {
                            Text(registerViewModel.errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.top, 5)
                        }

                        Button(action: {
                            registerViewModel.registerUser(userViewModel: userViewModel, modelContext: modelContext)
                        }) {
                            Text("Register")
                        }
                        .buttonStyle(ThemedButtonStyle( backgroundColor: Color(theme.colors.secondaryButtonBackground)))
                            .frame(maxWidth: 200)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private func registerAndDismiss() {
        registerViewModel.registerUser(userViewModel: userViewModel, modelContext: modelContext)
        
        // If there's no error, dismiss the view
        if !registerViewModel.showError {
            dismiss()
        }
    }
}
