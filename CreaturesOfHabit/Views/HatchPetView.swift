//
//  HatchPetView.swift
//  CreaturesOfHabit
//
//  Created by Mika Manaligod on 2024-11-08.
//


import SwiftUI

struct HatchPetView: View {
    @State private var isHatched = false
    
    var body: some View {
        VStack(spacing: 20) {
            if isHatched {
                
                Image("slime")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.orange)
                    .padding()
                
                Text("You hatched a slime!")
                    .font(.title3)
                    .fontWeight(.bold)
//                    .padding(.top, 1)
            } else {
                Spacer()
                Image("egg")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.top, 70)
                
                Spacer()
                Button(action: {
                    withAnimation {
                        isHatched.toggle()
                    }
                }) {
                    
                    Text("Tap to Hatch Your Creature!")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .padding(15)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                    
                    
                }.padding(.bottom, 100)
                
                
            }
            
                        if isHatched {
                            NavigationLink(destination: SelectGoalsView()) {
                                Text("Continue")
                                .fontWeight(.bold)
                                    .padding()
                                    .background(Color.yellow)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                                   
                            }
                        }
        }
        //        .navigationTitle("Hatch Your Pet")
    }
}

#Preview {
    HatchPetView()
}
