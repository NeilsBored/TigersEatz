//
//  SubscriptionSettingsView.swift
//  TigerEats
//
//  Created by Shane John on 3/9/25.
//

import SwiftUI

struct SubscriptionSettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var currentPlan: String = "Student Premium"
    @State private var renewalDate: String = "April 30, 2025"
    @State private var autoRenewEnabled: Bool = true

    var body: some View {
        Form {
            Section(header: Text("Current Plan")) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(currentPlan)
                        .font(.headline)
                    Text("Renews on \(renewalDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("Subscription Options")) {
                Toggle(isOn: $autoRenewEnabled) {
                    Text("Auto-Renew")
                }

                Button(action: {
                    // Upgrade logic
                }) {
                    HStack {
                        Text("Upgrade Plan")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                }

                Button(action: {
                    // Cancel logic
                }) {
                    HStack {
                        Text("Cancel Subscription")
                            .foregroundColor(.red)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationBarTitle("Subscriptions Settings", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        })
    }
}

struct SubscriptionSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SubscriptionSettingsView()
        }
    }
}
