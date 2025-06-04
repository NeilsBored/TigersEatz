import SwiftUI

struct CardModifier: ViewModifier {
    let isSelected: Bool
    let anySelected: Bool
    let selectedBorderColor: Color

    func body(content: Content) -> some View {
        content
            .scaleEffect(isSelected ? 1.02 : 1)
            .shadow(color: isSelected ? selectedBorderColor.opacity(0.5) : .clear,
                    radius: isSelected ? 5 : 0)
            .animation(.easeInOut, value: isSelected)
    }
}
