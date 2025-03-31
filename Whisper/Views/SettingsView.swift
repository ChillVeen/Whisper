//
//  SettingsView.swift
//  Whisper
//
//  Created by Praveen Singh on 12/12/24.
//

import SwiftUI
import MultipeerConnectivity

struct SettingsView: View {
    // Remove @ObservedObject connectivityManager
    @EnvironmentObject var mc: MCManager
    @AppStorage("isEncryptionEnabled") private var isEncryptionEnabled = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    NavigationLink(destination: ProfileView()) {
                        Text("Profile")
                    }
                }

                Section(header: Text("App Theme")) {
                    ThemePicker()
                }
                
                Section(header: Text("Encryption")) {
                    Toggle("End-to-End Encryption", isOn: $isEncryptionEnabled)
                        .onChange(of: isEncryptionEnabled) { newValue in
                            mc.isEncryptionEnabled = newValue
                        }
                }

                Section(header: Text("About")) {
                    NavigationLink(destination: AboutView()) {
                        Text("About Whisper")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

