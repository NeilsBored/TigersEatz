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
            VStack(alignment: .leading, spacing: 20) {
                
                WalletTabsView(selectedTab: $selectedTab, walletBalance: $walletBalance)
                    .padding(.top)
                
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
                                Text("email@example.com")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                        .padding(.vertical, 5)
                    }
                    
                    Section(header: Text("Profile Settings")) {
                        Toggle(isOn: $notificationsEnabled) {
                            Text("Enable Notifications")
                        }
                        Toggle(isOn: $darkModeEnabled) {
                            Text("Dark Mode")
                        }
                        Toggle(isOn: $OthersEnabled) {
                            Text("Others")
                        }
                    }
                        
                        Section(header: Text("App Settings")) {
                            Text("Enable Notifications")
                            Text("Enable Notifications")
                            Text("Enable Notifications")
                            
                                    
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
