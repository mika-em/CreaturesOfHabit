//
//  StatRowView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-06.
//

import SwiftUI

struct StatRowView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .multilineTextAlignment(.center)
        .padding(.vertical, 1)
        .padding(.horizontal, 60)
    }
}

#Preview {
    StatRowView(title: "Level", value: "5")
}
