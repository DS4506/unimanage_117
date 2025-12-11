
import SwiftUI

struct SettingsView: View {
    @State private var showSignOutAlert = false
    @State private var isDarkMode = false
    @State private var notificationsEnabled = true
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Form {
                    Section {
                        HStack(spacing: 16) {
                            Image(systemName: "person.crop.circle.badge.checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.indigo)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Prof. Gemini")
                                    .font(.headline)
                                Text("Faculty ID: #992-881")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                        
                        NavigationLink("Edit Profile") {
                            Text("Edit Profile Placeholder")
                        }
                    } header: {
                        Text("Account")
                    }
                    
                    Section("Preferences") {
                        Toggle(isOn: $isDarkMode) {
                            Label("Dark Mode", systemImage: "moon.fill")
                        }
                        .tint(.indigo)
                        
                        Toggle(isOn: $notificationsEnabled) {
                            Label("Push Notifications", systemImage: "bell.badge.fill")
                        }
                        .tint(.indigo)
                    }
                    
                    Section("Support") {
                        NavigationLink {
                            Text("Help Center")
                        } label: {
                            Label("Help Center", systemImage: "questionmark.circle")
                        }
                        
                        NavigationLink {
                            Text("Report a Bug")
                        } label: {
                            Label("Report an Issue", systemImage: "exclamationmark.bubble")
                        }
                    }
                    
                    Section {
                        Button(role: .destructive) {
                            showSignOutAlert = true
                        } label: {
                            HStack {
                                Text("Sign Out")
                                Spacer()
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                            }
                        }
                        .accessibilityIdentifier("SignOutButton")
                    } header: {
                        Text("Session")
                    }
                }
                
                // --- THE BUG (Trap #3) ---
                // A "Version Info" footer that sits at the bottom.
                VStack {
                    Spacer()
                    Text("UniManage v2.1.0 (Build 302)")
                        .font(.caption2)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 500)
                .background(Color.white.opacity(0.001))
                .allowsHitTesting(false)
            }
            .navigationTitle("Settings")
            .alert("Sign Out?", isPresented: $showSignOutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) { }
            }
        }
    }
}

