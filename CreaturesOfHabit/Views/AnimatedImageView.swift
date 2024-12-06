//
//  AnimatedImageView.swift
//  CreaturesOfHabit
//
//  Created by Cheryl  Lau on 2024-12-05.
//

import SwiftUI

struct AnimatedImageView: View {
    @State private var showFirstImage = true
    @State private var timer: Timer?  // Store the timer to control its lifecycle
    
    let firstImageName: String
    let secondImageName: String
    let animationDuration: Double
    
    var body: some View {
        VStack {
            Image(showFirstImage ? firstImageName : secondImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .transition(.opacity) // Use opacity for a smooth transition
                .onAppear {
                    startImageCycle()
                }
                .onDisappear {
                    stopImageCycle()
                }
        }
    }
    
    private func startImageCycle() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            showFirstImage.toggle()
        }
    }
    
    func stopImageCycle() {
        timer?.invalidate()
        timer = nil
    }
}



#Preview {
    AnimatedImageView(
        firstImageName: "dragon_baby",
        secondImageName: "dragon_baby2",
        animationDuration: 0.4
    )
}
