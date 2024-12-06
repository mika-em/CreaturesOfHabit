//
//  LoginView.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-22.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var userViewModel: UserViewModel
    @State private var username = ""
    @State private var password = ""
    var onLogin: (() -> Void)?
    @Environment(\.theme) private var theme
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Login")
                .font(Font(theme.fonts.headerFont))
                .fontWeight(.bold)
                .foregroundColor(Color(theme.colors.primaryText))
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            if let errorMessage = userViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                userViewModel.login(username: username, password: password, modelContext: modelContext)
                if userViewModel.isAuthenticated {
                    onLogin?()
                }
            }) {
                Text("Login")
                    .font(Font(theme.fonts.buttonFont))
                    .padding()
                    .background(Color(theme.colors.primaryButtonBackground))
                    .foregroundColor(Color(theme.colors.primaryButtonForeground))
                    .cornerRadius(20)
            }
            .buttonStyle(ThemedButtonStyle(backgroundColor: Color(theme.colors.primaryButtonBackground)))
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: theme.gradients.defaultGradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoginView(userViewModel: UserViewModel(), onLogin: nil)
        .environment(\.theme, ThemeManager.shared)
}
