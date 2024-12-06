import SwiftUI

struct ThemedButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(theme.fonts.buttonFont)) // Use the theme's button font
            .frame(height: theme.buttons.buttonHeight) // Consistent height
            .padding(.horizontal, 20) // Add horizontal padding for a wider button
            .background(
                configuration.isPressed
                    ? Color(theme.colors.primaryButtonBackground).opacity(0.8) // Darker when pressed
                    : Color(theme.colors.primaryButtonBackground)
            )
            .foregroundColor(Color(theme.colors.primaryButtonForeground)) // Consistent text color
            .cornerRadius(theme.buttons.cornerRadius) // Rounded corners
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Add press animation
            .animation(.easeInOut, value: configuration.isPressed)
    }
}