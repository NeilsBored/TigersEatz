import SwiftUI

struct CircularProgressView: View {
    let progress: Double

    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(Color.blue, lineWidth: 4)
            .rotationEffect(.degrees(-90))
            .animation(.easeInOut, value: progress)
    }
}
