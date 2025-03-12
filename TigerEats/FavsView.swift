import SwiftUI

struct FavoritesView: View {
    // Dummy list of favorite restaurants
    
    let favoriteRestaurants: [Restaurant] = [
         Restaurant(
             id: 1,
             imageName: "Chicky",
             title: "Chick-fil-A",
             address: "201 Fernow Street",
             capacity: .kindaBusy,
             openStatus: "Open",
             waitTime: 18,
             dietLabel: "Gluten-Free",
             costLabel: "$$",
             borderColor: .red
         ),
         Restaurant(
             id: 2,
             imageName: "Dish",
             title: "The Dish - DH",
             address: "511 Fort Hill Street",
             capacity: .notBusy,
             openStatus: "Open",
             waitTime: 26,
             dietLabel: "Gluten-Free",
             costLabel: "$$",
             borderColor: .orange
         )
    ]
    
    
    @State private var selectedTab: WalletView.Tab = .favorites
    @State private var walletBalance: Double = 100.0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
    
                
                
                WalletTabsView(selectedTab: $selectedTab, walletBalance: $walletBalance)
                
                // List of favorite restaurants
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(favoriteRestaurants) { restaurant in
                            RestaurantCard(
                                restaurant: restaurant,
                                selectedCardId: .constant(nil),
                                swipeOffsets: .constant([Int: CGFloat]()),
                                onRemove: { /* No removal action in favorites */ }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                       
                    }) {
                        HStack {
                            Image(systemName: "house")
                                .foregroundColor(Color(red: 82/255, green: 45/255, blue: 128/255))
                            Text("Back")
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
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
