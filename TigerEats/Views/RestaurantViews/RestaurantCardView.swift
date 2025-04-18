//
//  RestaurantCardView.swift
//  TigerEats
//
//  Created by Shane John on 4/16/25.
//

import SwiftUI

// MARK: - RestaurantCard
struct RestaurantCard: View {
    let restaurant: Restaurant
    @Binding var selectedCardId: Int?
    @Binding var swipeOffsets: [Int: CGFloat]
    let onRemove: () -> Void

    private var offset: CGFloat {
        swipeOffsets[restaurant.id] ?? 0
    }

    var body: some View {
        ZStack(alignment: .leading) {
            // Background: option buttons
            VStack(spacing: 10) {
                Button("Start Order") {
                    // start order
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 130, height: 43)
                .background(Color.blue)
                .cornerRadius(5)
                .shadow(radius: 1)

                NavigationLink(destination: HomeScreenView()) {
                    Text("View Info")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 130, height: 35)
                        .background(Color.gray)
                        .cornerRadius(5)
                }

                Button("Remove") {
                    onRemove()
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 130, height: 37)
                .background(Color.clear)
                .border(Color.gray, width: 3)
                .cornerRadius(5)
            }
            .frame(maxHeight: .infinity)
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .scaleEffect(
                selectedCardId == nil || selectedCardId == restaurant.id
                    ? 0.95 : 0.85
            )

            // Foreground: card content
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center, spacing: 12) {
                    Image(restaurant.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)

                    VStack(alignment: .leading) {
                        HStack {
                            Text(restaurant.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            CapacityIndicator(level: restaurant.capacity)
                        }
                        Text(restaurant.address)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(alignment: .center, spacing: 40) {
                    VStack(alignment: .leading) {
                        Label(
                            restaurant.openStatus,
                            systemImage: restaurant.openStatus == "Open"
                                ? "checkmark.circle" : "xmark.circle"
                        )
                        Label {
                            Text("\(restaurant.waitTime) mins")
                        } icon: {
                            Image(systemName: "clock")
                        }
                    }

                    VStack(alignment: .leading) {
                        Label(restaurant.dietLabel, systemImage: "leaf")
                        Label(restaurant.costLabel, systemImage: "dollarsign.circle")
                    }

                    Spacer()

                    Image(systemName: "chevron.left")
                        .font(.system(size: 30))
                        .foregroundColor(
                            selectedCardId == restaurant.id
                                ? .white : .gray
                        )
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        restaurant.borderColor,
                        lineWidth: selectedCardId == restaurant.id ? 3 : 0
                    )
            )
            .modifier(
                CardModifier(
                    isSelected: selectedCardId == restaurant.id,
                    anySelected: selectedCardId != nil,
                    selectedBorderColor: restaurant.borderColor
                )
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            swipeOffsets[restaurant.id] = max(value.translation.width, -150)
                        }
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut) {
                            swipeOffsets[restaurant.id] = value.translation.width < -80
                                ? -150 : 0
                        }
                    }
            )
            .offset(x: offset)
            .contextMenu {
                Button("Start Order") { /* order */ }
                Button("View Info") { /* info */ }
                Button("Remove") { onRemove() }
            }
            .onTapGesture {
                if offset != 0 {
                    withAnimation(.easeInOut) { swipeOffsets[restaurant.id] = 0 }
                } else {
                    selectedCardId = restaurant.id
                }
            }
        }
        .animation(.spring(), value: swipeOffsets)
    }
}

// MARK: - Preview
struct RestaurantCard_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCard(
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
            ),
            selectedCardId: .constant(nil),
            swipeOffsets: .constant([:]),
            onRemove: {}
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
