//
//  RegisterViewViewModel.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-27.
//

import Foundation
import SwiftData

class RegisterViewViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var showError = false
    @Published var errorMessage = ""

    func registerUser(userViewModel: UserViewModel, modelContext: ModelContext) {
        guard !username.isEmpty, !password.isEmpty else {
            showError = true
            errorMessage = "Username and password cannot be empty."
            return
        }

        guard password == confirmPassword else {
            showError = true
            errorMessage = "Passwords do not match."
            return
        }

        do {
            // Check if the username already exists
            let existingUsers = try modelContext.fetch(FetchDescriptor<User>())
            if existingUsers.contains(where: { $0.username == username }) {
                showError = true
                errorMessage = "Username already exists."
                return
            }

            // Create a new user
            let newUser = User(username: username, password: password)
            modelContext.insert(newUser)
            try modelContext.save()

            // Optionally, log in the user after registration
            userViewModel.login(username: username, password: password, modelContext: modelContext)
        } catch {
            showError = true
            errorMessage = "Failed to register: \(error.localizedDescription)"
        }
    }
}
