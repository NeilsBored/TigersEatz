import SwiftUI

struct RestaurantProfileView: View {
    let restaurant: Restaurant

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .padding(.bottom, 8)

                Text(restaurant.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(restaurant.address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(spacing: 20) {
                    Label(restaurant.openStatus,
                          systemImage: restaurant.openStatus == "Open" ? "checkmark.circle" : "xmark.circle")
                    Label("\(restaurant.waitTime) mins", systemImage: "clock")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: 8) {
                    Label(restaurant.dietLabel, systemImage: "leaf")
                    Label(restaurant.costLabel, systemImage: "dollarsign.circle")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("Restaurant Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RestaurantProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantProfileView(
                restaurant: Restaurant(
                    id: 1,
                    imageName: "Chicky",
                    title: "Chick-fil-A",
                    address: "201 Fernow St.",
                    capacity: .kindaBusy,
                    openStatus: "Open",
                    waitTime: 12,
                    dietLabel: "Gluten‑Free",
                    costLabel: "$$",
                    borderColor: .red
                )
            )
        }
    }
}
