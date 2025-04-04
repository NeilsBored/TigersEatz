//
//  PrivacySettingsView.swift
//  TigerEats
//
//  Created by Shane John on 4/2/25.
//

import SwiftUI

struct PrivacySettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var locationAccess: Bool = true
    @State private var personalizedAds: Bool = false
    @State private var shareUsageData: Bool = false
    @State private var showProfilePublicly: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Data Permissions")) {
                Toggle("Location Access", isOn: $locationAccess)
                Toggle("Share Usage Data", isOn: $shareUsageData)
            }

            Section(header: Text("Personalization")) {
                Toggle("Personalized Ads", isOn: $personalizedAds)
                
            }

            Section {
                Button(role: .destructive) {
                    // Reset to default values
                    locationAccess = true
                    personalizedAds = false
                    shareUsageData = false
                    showProfilePublicly = false
                } label: {
                    Text("Reset to Default Settings")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Privacy Settings")
                    .font(.headline)
                    
            }
        }
    }
}

struct PrivacySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrivacySettingsView()
        }
    }
}
