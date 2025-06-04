import SwiftUI

struct RestaurantListView: View {
    @State private var restaurants: [Restaurant] = [
        Restaurant(id: 1,
                   imageName: "Chicky",
                   title: "Chick-fil-A",
                   address: "201 Fernow St.",
                   capacity: .kindaBusy,
                   openStatus: "Open",
                   waitTime: 12,
                   dietLabel: "Gluten-Free",
                   costLabel: "$$",
                   borderColor: .red),
        Restaurant(id: 2,
                   imageName: "Pizza",
                   title: "Pizza Palace",
                   address: "99 College Ave",
                   capacity: .busy,
                   openStatus: "Closed",
                   waitTime: 0,
                   dietLabel: "Veggie",
                   costLabel: "$$",
                   borderColor: .blue)
    ]

    @State private var selectedCardId: Int?
    @State private var swipeOffsets: [Int: CGFloat] = [:]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(restaurants) { restaurant in
                        RestaurantCard(
                            restaurant: restaurant,
                            selectedCardId: $selectedCardId,
                            swipeOffsets: $swipeOffsets,
                            onRemove: { withAnimation { restaurants.removeAll { $0.id == restaurant.id } } }
                        )
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Restaurants")
        }
        .animation(.spring(), value: restaurants)
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
    }
}
