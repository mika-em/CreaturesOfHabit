//
//  RegisterView.swift
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
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Register")
                    .font(Font(theme.fonts.headerFont))
                    .fontWeight(.bold)
                    .foregroundColor(Color(theme.colors.primaryText))
                
                TextField("Username", text: $registerViewModel.username)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                     .background(Color.white)
                     .cornerRadius(15)
                     .padding(.horizontal)
                
                SecureField("Password", text: $registerViewModel.password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                    .padding()
                   .background(Color.white)
                   .cornerRadius(15)
                   .padding(.horizontal)

                
                SecureField("Confirm Password", text: $registerViewModel.confirmPassword)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                    .padding()
                   .background(Color.white)
                   .cornerRadius(15)
                   .padding(.horizontal)
                
                if registerViewModel.showError {
                    Text(registerViewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    registerAndDismiss()
                }) {
                    Text("Register")
                        .padding()
                        .font(Font(theme.fonts.buttonFont))
                        .background(Color(theme.colors.primaryButtonBackground))
                        .foregroundColor(Color(theme.colors.primaryButtonForeground))
                        .cornerRadius(20)
                }
                .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.primaryButtonBackground)))
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

#Preview {
    RegisterView(userViewModel: UserViewModel())
     .environment(\.theme, ThemeManager.shared)
}
