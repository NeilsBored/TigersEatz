//
//  ProfileView.swift
//  TigerEats
//
//  Created by Shane John on 3/9/25.
//

import SwiftUI


struct ProfileMenuView: View {

    @State private var selectedTab: WalletView.Tab = .profile
    @State private var walletBalance: Double = 100.0
    @State private var notificationsEnabled: Bool = true
    @State private var darkModeEnabled: Bool = false
    @State private var OthersEnabled: Bool = false

    var body: some View {
        
        
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                WalletTabsView(selectedTab: $selectedTab, walletBalance: $walletBalance)
                    .offset(x:-6, y: -15)
                    .toolbar {
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                               
                            }) {
                                HStack {
                                    Text("Back Home")
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
                
                Form {
                    Section(header: Text("Profile Information")) {
                        HStack(spacing: 15) {
                            /*Image("me")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())*/
                            
                            VStack(alignment: .leading) {
                                Text("Student Membership")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("Sean Johnson")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Text("seanj@clemson.edu")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                        .padding(.vertical, 5)
                    }
                    
                    Section(header: Text("Profile Settings")) {
                        HStack{
                            Text("Edit Profile Information")
                            Image(systemName: "chevron.right")
                                .foregroundColor(.blue)
                        }
                        HStack{
                            Text("Favorites Settings")
                            Image(systemName: "chevron.right")
                                .foregroundColor(.blue)
                        }
                        HStack{
                            Text("Payment Settings")
                            Image(systemName: "chevron.right")
                                .foregroundColor(.blue)
                        }
                        HStack{
                            Text("Subscriptions Settings")
                            Image(systemName: "chevron.right")
                                .foregroundColor(.blue)
                        }
                        
                    }
                        
                        Section(header: Text("App Settings")) {
                            
                            Toggle(isOn: $notificationsEnabled) {
                                Text("Enable Notifications")
                                    
                            }
                            Toggle(isOn: $darkModeEnabled) {
                                Text("Dark Mode")
                            }
                           // Toggle(isOn: $OthersEnabled) {
                             //   Text("Others")
                           // }
                            HStack{
                                Text("Notification Settings")
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.blue)
                            }
                            HStack{
                                Text("Privacy Settings")
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.blue)
                            }
                            HStack{
                                Text("Accessibility Settings")
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.blue)
                            }
                                }
                        
                    
                    
                    Section {
                        Button(action: {
                            // Log out action
                        }) {
                            HStack {
                                Spacer()
                                Text("Log Out")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                    }
                    
                    
                }
               
            }
        }
    }
}

struct ProfileMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuView()
    }
}
