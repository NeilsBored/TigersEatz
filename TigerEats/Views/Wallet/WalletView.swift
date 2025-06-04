import SwiftUI

struct WalletView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Sample Receipt", destination: ReceiptDetailView())
            }
            .navigationTitle("Wallet")
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
