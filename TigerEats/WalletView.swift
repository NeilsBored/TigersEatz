import SwiftUI

struct WalletView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var walletBalance: Double = 10.13
    @State private var searchText: String = ""
    @State private var showingFilterPicker: Bool = false
    @State private var selectedFilter: String = "All"
    let maxBalance: Double = 200.00
    @State private var dailyBudgetAmount: String = ""
    
    enum Tab {
        case favorites, profile, wallet
    }
    @State private var selectedTab: Tab = .wallet
    
    let balanceSectionWidth: CGFloat = 350
    let recentTransactions: [Transaction] = [
         Transaction(id: 1, description: "Starbucks Coffee", amount: -4.50, date: "Mar 9, 25"),
         Transaction(id: 2, description: "Deposit", amount: 50.00, date: "Mar 8, 25"),
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                WalletTabsView(selectedTab: $selectedTab, walletBalance: $walletBalance)
                WalletBalanceView(walletBalance: walletBalance, maxBalance: maxBalance, balanceSectionWidth: balanceSectionWidth)
                RecentTransactionsView(searchText: $searchText, showingFilterPicker: $showingFilterPicker, selectedFilter: $selectedFilter, recentTransactions: recentTransactions)
                Spacer()
            }
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Action to navigate back to home
                    }) {
                        HStack {
                            Image(systemName: "house")
                                .foregroundColor(Color(red: 82/255, green: 45/255, blue: 128/255))
                            Text("🔙")
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image("Clemson")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(red: 246/255, green: 103/255, blue: 51/255))
                        Text("TigerEatz")
                            .font(.headline)
                            .foregroundColor(Color(red: 82/255, green: 45/255, blue: 128/255))
                    }
                }
            }
            .sheet(isPresented: $showingFilterPicker) {
                VStack {
                    Text("Select Filter")
                        .font(.headline)
                        .padding()
                    Picker("Search Filter", selection: $selectedFilter) {
                        Text("All").tag("All")
                        Text("Open Now").tag("Open Now")
                        Text("Favorites").tag("Favorites")
                        Text("Nearby").tag("Nearby")
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .padding()
                    Button("Done") {
                        showingFilterPicker = false
                    }
                    .padding()
                }
                .presentationDetents([.fraction(0.28)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

// MARK: - Subviews

struct WalletTabsView: View {
    @Binding var selectedTab: WalletView.Tab
    @Binding var walletBalance: Double
    
    var body: some View {
        HStack(alignment: .center, spacing: 70) {
            Button(action: { selectedTab = .favorites }) {
                VStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: selectedTab == .favorites ? 45 : 30,
                               height: selectedTab == .favorites ? 45 : 30)
                        .foregroundColor(selectedTab == .favorites ? .red : .primary)
                    if selectedTab == .favorites {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.red)
                    }
                    Text("Favorites")
                        .font(.caption)
                        .foregroundColor(selectedTab == .favorites ? .red : .primary)
                }
            }
            Button(action: { selectedTab = .profile }) {
                VStack(spacing: 4) {
                    Image("me")
                        .resizable()
                        .scaledToFill()
                        .frame(width: selectedTab == .profile ? 70 : 30,
                               height: selectedTab == .profile ? 70 : 30)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(selectedTab == .profile ? Color.blue : Color.clear, lineWidth: 3))
                    if selectedTab == .profile {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                    }
                    Text("Profile")
                        .font(.caption)
                        .foregroundColor(selectedTab == .profile ? .blue : .primary)
                }
            }
            Button(action: { selectedTab = .wallet }) {
                VStack(spacing: 4) {
                    Image(systemName: "creditcard.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: selectedTab == .wallet ? 45 : 30,
                               height: selectedTab == .wallet ? 45 : 30)
                        .foregroundColor(selectedTab == .wallet ? (walletBalance >= 0 ? .green : .red) : .primary)
                    if selectedTab == .wallet {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(walletBalance >= 0 ? .green : .red)
                    }
                    Text("Wallet")
                        .font(.caption)
                        .foregroundColor(selectedTab == .wallet ? (walletBalance >= 0 ? .green : .red) : .primary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
}

struct WalletBalanceView: View {
    var walletBalance: Double
    var maxBalance: Double
    var balanceSectionWidth: CGFloat
    
    var body: some View {
        HStack(alignment: .center, spacing: 35) {
            VStack(alignment: .trailing, spacing: 1) {
                Text("Total Spent Today:")
                    .font(.title2)
                Text("$\(String(format: "%.2f", walletBalance))")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("Total Remaining Today:")
                    .font(.title2)
                Text("$\(String(format: "%.2f", walletBalance))")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            .offset(x:10, y:-25)
            VStack(){
                CircularProgressView(
                    progress: walletBalance / maxBalance,
                    customForegroundColor: .green
                )
                .scaleEffect(1.5)
                
                .padding(.bottom, 25)
                Text("Update Budget")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
        }
        .offset(x: -11, y: -12)
        .frame(width: balanceSectionWidth, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(height: 150)
        .padding(.horizontal)
        

    }
}



struct RecentTransactionsView: View {
    @Binding var searchText: String
    @Binding var showingFilterPicker: Bool
    @Binding var selectedFilter: String
    var recentTransactions: [Transaction]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Transactions")
                .font(.headline)
                .padding(.top, 40)
                .padding(.horizontal)
            HStack {
                TextField("Search restaurants...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 318, height: 30)
                    .padding(.leading, 5)
                    .background(colorScheme == .dark ? Color(.systemGray6) : .white)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                Button {
                    showingFilterPicker = true
                } label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
            .padding(.bottom, 1)
            .padding(.horizontal)
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(recentTransactions) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
    }
}

// MARK: - Supporting Models & Views

struct Transaction: Identifiable {
    let id: Int
    let description: String
    let amount: Double
    let date: String
}

struct TransactionRow: View {
    var transaction: Transaction
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.description)
                    .font(.headline)
                Text(transaction.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(transaction.amount >= 0 ? "+" : "")$\(String(format: "%.2f", transaction.amount))")
                .font(.subheadline)
                .foregroundColor(transaction.amount >= 0 ? .green : .red)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
