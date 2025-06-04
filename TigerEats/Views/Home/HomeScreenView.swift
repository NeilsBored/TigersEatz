import SwiftUI

struct HomeScreenView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            RestaurantListView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .scaleEffect(selectedTab == 0 ? 1.2 : 1.0)
                    Text("Home")
                }
                .tag(0)

            FavoritesView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "star.fill" : "star")
                        .scaleEffect(selectedTab == 1 ? 1.2 : 1.0)
                    Text("Favorites")
                }
                .tag(1)

            WalletView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "creditcard.fill" : "creditcard")
                        .scaleEffect(selectedTab == 2 ? 1.2 : 1.0)
                    Text("Wallet")
                }
                .tag(2)

            ProfileMenuView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                        .scaleEffect(selectedTab == 3 ? 1.2 : 1.0)
                    Text("Profile")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "gearshape.fill" : "gearshape")
                        .scaleEffect(selectedTab == 4 ? 1.2 : 1.0)
                    Text("Settings")
                }
                .tag(4)
        }
        .animation(.easeInOut, value: selectedTab)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
