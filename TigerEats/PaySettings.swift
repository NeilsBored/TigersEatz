//
//  PaymentSettingsView.swift
//  TigerEats
//
//  Created by Shane John on 4/2/25.
//

import SwiftUI

struct PaymentSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedCardIndex: Int = 0 // Default to the first card
    @State private var paymentMethods: [String] = [
        "Visa •••• 1234",
        "Mastercard •••• 5678"
    ]
    
    var body: some View {
        Form {
            Section(header: Text("Saved Payment Methods")) {
                ForEach(paymentMethods.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(paymentMethods[index])
                                .font(.body)
                            if selectedCardIndex == index {
                                Text("Default")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        }
                        Spacer()
                        if selectedCardIndex == index {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Button(action: {
                                selectedCardIndex = index
                            }) {
                                Text("Set as Default")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Section {
                Button(action: {
                    // Code to add a new payment method
                }) {
                    Label("Add Payment Method", systemImage: "plus.circle")
                        .foregroundColor(.blue)
                }
            }
            
            Section(header: Text("Billing Info")) {
                NavigationLink(destination: Text("Edit Billing Address")) {
                    Text("Edit Billing Address")
                }
            }
        }
        .navigationTitle("Payment Settings")
        .navigationBarTitleDisplayMode(.inline)
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
        }
    }
}

struct PaymentSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PaymentSettingsView()
        }
    }
}
