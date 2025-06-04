import SwiftUI

struct ReceiptDetailView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Text("Receipt details coming soon")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Receipt")
    }
}

struct ReceiptDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReceiptDetailView()
        }
    }
}
