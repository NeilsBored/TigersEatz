import SwiftUI

struct MenuItemDetailView: View {
    let menuItem: MenuItem
    let restaurant: Restaurant // Assuming Restaurant is defined elsewhere

    var body: some View {
        VStack(spacing: 20) {
           

            // Restaurant Info
            VStack(spacing: 2) {
                Text(restaurant.title)
                    .font(.headline)
                Text(restaurant.address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(restaurant.borderColor.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            // Title
            Text(menuItem.name)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            // Plate Graphic
            Image(systemName: "fork.knife.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.gray)
            
            // Item Options
            VStack(alignment: .leading, spacing: 8) {
                Text("Item Options")
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("Chicken, Steak, Turkey, Veggie")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // Allergen Info
            VStack(alignment: .leading, spacing: 8) {
                Text("Allergen Info")
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("Contains Peanut")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // Nutritional Info
            VStack(alignment: .leading, spacing: 8) {
                Text("Nutritional Info")
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("Protein: 23g\nFat: 200g\nSodium: 10mg")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // Add to Order Button
            Button(action: {
                // Action to add item
            }) {
                Text("Add To Order")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.vertical)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MenuItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuItemDetailView(
                menuItem: MenuItem(
                    id: 10,
                    name: "Spicy Chicken Sandwich",
                    detail: "Served with pickles on a toasted buttered bun",
                    price: 6.79
                ),
                restaurant: Restaurant(
                    id: 42,
                    imageName: "Chicky",
                    title: "Chick-fil-A at Fernow",
                    address: "201 Fernow Street",
                    capacity: .kindaBusy,
                    openStatus: "Open",
                    waitTime: 12,
                    dietLabel: "Gluten‑Free Options",
                    costLabel: "$$",
                    borderColor: .red
                )
            )
        }
    }
}
