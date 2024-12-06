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
    var onLogin: (() -> Void)? // Add the onLogin callback

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let errorMessage = userViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button(action: {
                userViewModel.login(username: username, password: password, modelContext: modelContext)
                if userViewModel.isAuthenticated { // Trigger the onLogin callback if authenticated
                    onLogin?()
                }
            }) {
                Text("Login")
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
    }
}
