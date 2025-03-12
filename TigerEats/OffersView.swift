//
//  OffersView.swift
//  TigerEats
//
//  Created by Shane John on 3/9/25.
//

import SwiftUI

struct DiscountItemsView: View {
    // Model for a discount/limited item
    struct DiscountItem: Identifiable {
        let id: Int
        let imageName: String
        let title: String
        let description: String
        let discountPercentage: Int
    }
    
    // Example discount items
    let discountItems: [DiscountItem] = [
        DiscountItem(id: 1, imageName: "item1", title: "Limited Burger Deal", description: "Enjoy a juicy burger with fries at 25% off.", discountPercentage: 25),
        DiscountItem(id: 2, imageName: "item2", title: "Pizza Party Special", description: "Savor our signature pizza at 20% off this week.", discountPercentage: 20),
        DiscountItem(id: 3, imageName: "item3", title: "Sushi Delight", description: "Fresh sushi with a 30% discount for a limited time.", discountPercentage: 30)
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Limited Time")
                    .font(.title)
                    //.fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(discountItems) { item in
                            DiscountItemCard(item: item)
                                .padding(.horizontal)
                        }
                    }
                }
                Text("Student Discounts")
                    .font(.title)
                    //.fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(discountItems) { item in
                            DiscountItemCard(item: item)
                                .padding(.horizontal)
                        }
                    }
                }
                Text("Reward Programs")
                    .font(.title)
                    //.fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(discountItems) { item in
                            DiscountItemCard(item: item)
                                .padding(.horizontal)
                        }
                    }
                }
                
            }
            
            .navigationTitle("Available Offers:")
        }
    }
}

struct DiscountItemCard: View {
    let item: DiscountItemsView.DiscountItem
    
    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(item.discountPercentage)% OFF")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(radius: 2)
    }
}

struct DiscountItemsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscountItemsView()
    }
}
