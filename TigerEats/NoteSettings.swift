import SwiftUI

struct NotificationSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var orderUpdates: Bool = true
    @State private var promotions: Bool = false
    @State private var soundEnabled: Bool = true
    @State private var vibrationEnabled: Bool = true

    var body: some View {
        Form {
            Section(header: Text("Notification Preferences")) {
                Toggle(isOn: $orderUpdates) {
                    Text("Order Updates")
                }
                Toggle(isOn: $promotions) {
                    Text("Promotions & Offers")
                }
            }

            Section(header: Text("Notification Sounds")) {
                Toggle(isOn: $soundEnabled) {
                    Text("Enable Sound")
                }
                Toggle(isOn: $vibrationEnabled) {
                    Text("Enable Vibration")
                }
            }
        }
        .navigationTitle("Notification Settings")
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

struct NotificationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationSettingsView()
        }
    }
}
