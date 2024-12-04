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
    @ObservedObject var userViewModel: UserViewModel
    @StateObject private var registerViewModel = RegisterViewViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Username", text: $registerViewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $registerViewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $registerViewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if registerViewModel.showError {
                Text(registerViewModel.errorMessage)
                    .foregroundColor(.red)
            }

            Button(action: {
                registerViewModel.registerUser(userViewModel: userViewModel, modelContext: modelContext)
            }) {
                Text("Register")
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
