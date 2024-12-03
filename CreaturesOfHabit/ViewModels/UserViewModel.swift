//
//  UserViewModel.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-27.
//

import Foundation
import SwiftData

class UserViewModel: ObservableObject {
    @Published var currentUser: User? = nil
    @Published var isAuthenticated = false
    @Published var errorMessage: String? = nil

    func login(username: String, password: String, modelContext: ModelContext) {
        do {
            // Fetch the user matching the username
            let users = try modelContext.fetch(FetchDescriptor<User>())
            
            if let user = users.first(where: { $0.username == username && $0.password == password }) {
                user.isLoggedIn = true
                try modelContext.save()
                
                currentUser = user
                isAuthenticated = true
                errorMessage = nil
            } else {
                isAuthenticated = false
                errorMessage = "Invalid username or password"
            }
        } catch {
            errorMessage = "An error occurred: \(error.localizedDescription)"
        }
    }
    
    func logout(modelContext: ModelContext) {
        guard let user = currentUser else { return }

        do {
            user.isLoggedIn = false
            try modelContext.save()
            currentUser = nil
            isAuthenticated = false
        } catch {
            errorMessage = "Logout attempt failed: \(error.localizedDescription)"
        }
    }

    func fetchLoggedInUser(modelContext: ModelContext) {
        do {
            let users = try modelContext.fetch(FetchDescriptor<User>())
            if let user = users.first(where: { $0.isLoggedIn }) {
                currentUser = user
                isAuthenticated = true
            }
        } catch {
            errorMessage = "Failed to fetch logged-in user: \(error.localizedDescription)"
        }
    }
}
