//
//  AccessibilitySettingsView.swift
//  TigerEats
//
//  Created by Shane John on 3/9/25.
//

import SwiftUI

struct AccessibilitySettingsView: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var textScaling: Double = 1.0
    @State private var voiceOverEnabled: Bool = false
    @State private var highContrastMode: Bool = false
    @State private var reduceMotion: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Display")) {
                VStack(alignment: .leading) {
                    Text("Text Size")
                    Slider(value: $textScaling, in: 0.5...2.0, step: 0.1) {
                        Text("Text Size")
                    }
                    Text("Preview Text")
                        .font(.system(size: CGFloat(16 * textScaling)))
                        .foregroundColor(.gray)
                }
            }

            Section(header: Text("Visual & Motion")) {
                Toggle(isOn: $highContrastMode) {
                    Text("High Contrast Mode")
                }

                Toggle(isOn: $reduceMotion) {
                    Text("Reduce Motion")
                }
            }

            Section(header: Text("Auditory")) {
                Toggle(isOn: $voiceOverEnabled) {
                    Text("VoiceOver")
                }
            }
        }
        .navigationBarTitle("Accessibility Settings", displayMode: .inline)
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
        }
    }
}

struct AccessibilitySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccessibilitySettingsView()
        }
    }
}
