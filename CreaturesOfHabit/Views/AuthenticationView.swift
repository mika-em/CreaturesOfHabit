//
//  AuthenticationView.swift
//  CreaturesOfHabit
//
//  Created by Benny Li on 2024-12-05.
//

import SwiftUI

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.modelContext) private var modelContext
    var onLogin: (() -> Void)?
    @Environment(\.theme) private var theme
    
    var body: some View {
        ZStack {
            LinearGradient(
                           gradient: theme.gradients.defaultGradient,
                           startPoint: .top,
                           endPoint: .bottom
                       )
                       .ignoresSafeArea()
            
            VStack(spacing: 30) {
                          Spacer()

                LoginView(userViewModel: userViewModel, onLogin: onLogin)
                    .padding(.horizontal, 30)
                
                NavigationLink(destination: RegisterView(userViewModel: userViewModel)) {
                    Text("Don't have an account? Create One!")
                        .font(Font(theme.fonts.bodyFont))
                        .foregroundColor(Color(theme.colors.secondaryText))
                        .padding()
                }
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    AuthenticationView().environmentObject(UserViewModel())
}
