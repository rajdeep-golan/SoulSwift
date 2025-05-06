//
//  SettingsView.swift
//  Soul
//
//  Created by Prakashdeep Golan on 3/11/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                }
                .padding(.leading)

                Text("Profile Settings")
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()
            }
            .padding(.vertical, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Account Section
                    Text("Account")
                        .font(.headline)
                        .padding(.leading)

                    SettingsRow(icon: "person", text: "Profile")
                    SettingsRow(icon: "bell", text: "Notifications")
                    SettingsRow(icon: "lock", text: "Privacy")

                    // Preferences Section
                    Text("Preferences")
                        .font(.headline)
                        .padding(.leading)

                    SettingsRow(icon: "paintpalette", text: "Appearance")
                    SettingsRow(icon: "globe", text: "Language")

                    // Help & Support Section
                    Text("Help & Support")
                        .font(.headline)
                        .padding(.leading)

                    SettingsRow(icon: "questionmark.circle", text: "Help Center")
                    SettingsRow(icon: "info.circle", text: "About")

                    // Sign Out Button
                    Button(action: {
                        // Implement Sign Out action here
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding(.vertical)
            }

            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct SettingsRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 30, height: 30)
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
