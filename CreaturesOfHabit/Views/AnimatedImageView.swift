//
//  AnimatedImageView.swift
//  CreaturesOfHabit
//
//  Created by Cheryl  Lau on 2024-12-05.
//

import SwiftUI

struct AnimatedImageView: View {
    @State private var showFirstImage = true
    let firstImageName: String
    let secondImageName: String
    let animationDuration: Double

    var body: some View {
        VStack {
            // Display the current image
            Image(showFirstImage ? firstImageName : secondImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .transition(.opacity) // Use opacity for a smooth transition
                .onAppear {
                    startImageCycle()
                }
        }
    }

    // Method to cycle the images at regular intervals
    private func startImageCycle() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            showFirstImage.toggle() // No animation
        }
    }
}

#Preview {
    AnimatedImageView(
        firstImageName: "dragon_baby",
        secondImageName: "dragon_baby2",
        animationDuration: 0.3
    )
}
