//
//  User.swift
//  CreaturesOfHabit
//
//  Created by Alfrey Chan on 2024-11-13.
//

import Foundation
import SwiftData

@Model
class User {
    var id: UUID = UUID()
    var username: String
    var password: String
    var isLoggedIn: Bool = false
    @Relationship var creature: Creature? // remove nullability later

    init(username: String, password: String, creature: Creature? = nil) { // remove nil later
        self.username = username
        self.password = password
        self.creature = creature
    }
}
