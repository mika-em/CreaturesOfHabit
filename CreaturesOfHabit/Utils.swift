//
//  Utils.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-03.
//

import Foundation

enum Utils {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
