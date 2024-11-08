//
//  HomeView.swift
//  CreaturesOfHabit
//
//  Created by Conrad Christian on 2024-11-08.
//

import SwiftUI

struct MonsterView: View {
    @State var image = "slime"
    
    var body: some View {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if (image == "slime") {
                image = "slime2"
            } else {
                image = "slime"
            }
        }
        
        Image(image)
            .resizable()
            .frame(width: 200, height: 200)
            .foregroundColor(.orange)
            .padding()
    }
}

#Preview {
    MonsterView()
}
