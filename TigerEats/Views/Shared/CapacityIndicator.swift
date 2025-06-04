import SwiftUI

struct CapacityIndicator: View {
    let level: Restaurant.CapacityLevel

    private var color: Color {
        switch level {
        case .empty: return .green
        case .kindaBusy: return .yellow
        case .busy: return .red
        }
    }

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
            .overlay(Circle().stroke(Color.primary, lineWidth: 1))
            .animation(.easeInOut, value: level)
    }
}
