//
//  FavoritesSettingsView.swift
//  TigerEats
//
//  Created by Shane John on 3/9/25.
//

import SwiftUI

struct FavoritesSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var favoriteRestaurants: [String] = ["Einstein Bros.", "Chick-fil-A", "The Halal Shack"]
    @State private var newFavorite: String = ""
    
    // Function to return image name based on restaurant
    func imageName(for restaurant: String) -> String {
        switch restaurant {
        case "Einstein Bros.":
            return "bagel"
        case "Chick-fil-A":
            return "Chicky"
        case "The Halal Shack":
            return "Halal"
        default:
            return "default_food_icon" // Make sure to add this fallback image
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("Favorites Settings")
                        .font(.headline)
                    
                    Spacer()
                    
                    EditButton()
                        .padding(.trailing)
                }
                .padding(.vertical, 8)

                HStack {
                    TextField("Add a new favorite", text: $newFavorite)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        let trimmed = newFavorite.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty {
                            favoriteRestaurants.append(trimmed)
                            newFavorite = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .padding(.trailing)
                }
                .padding(.bottom, 10)
                
                if favoriteRestaurants.isEmpty {
                    Text("No favorites added yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(favoriteRestaurants, id: \.self) { restaurant in
                            HStack {
                                Image(imageName(for: restaurant))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                Text(restaurant)
                                    .font(.body)
                                    .padding(.leading, 5)
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete { indexSet in
                            favoriteRestaurants.remove(atOffsets: indexSet)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
    }
}

struct FavoritesSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSettingsView()
    }
}
