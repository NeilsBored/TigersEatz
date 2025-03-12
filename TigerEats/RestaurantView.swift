//
//  RestaurantView.swift
//  TigerEats
//
//  Created by Shane John on 3/9/25.
//

import SwiftUI


struct RestaurantProfileView: View {
   
    @State private var selectedTab: WalletView.Tab = .favorites
    @State private var walletBalance: Double = 100.0
    
    // Sample restaurant profile data
    let restaurantName: String = "Good Taste"
    let restaurantAddress: String = "123 Main Street, City"
    let restaurantDescription: String = "A cozy place where food and culture merge. Enjoy authentic flavors and a family-friendly atmosphere."
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                
                // Restaurant Profile content
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        Text(restaurantName)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(restaurantAddress)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Divider()
                        
                        Text("Description")
                            .font(.headline)
                        Text(restaurantDescription)
                            .font(.body)
                        
                       
                    }
                    .padding()
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
                            Text("Home")
                        }
                    }
                }
               
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image("Clemson")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("TigerEatz")
                            .font(.headline)
                            .foregroundColor(Color(red: 82/255, green: 45/255, blue: 128/255))
                    }
                }
            }
        }
    }
}

struct RestaurantProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantProfileView()
    }
}
