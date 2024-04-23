//
//  SettingsScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 20.04.2024.
//

import SwiftUI

struct SettingsScreen: View {
    @AppStorage("selectedAppearance") var selectedLanguage = 0
    @State var showAdminScreen = false
    @State var showProfileEditScreen = false
    @State private var fontSize: CGFloat = 15
    @State private var showLineNumbers = false
    @State private var showPreview = true
    
    let email: String = AuthService.shared.user?.email ?? ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Profile") {
                    NavigationLink(destination: EditProfileScreen(name: "Timon", surname: "Shwabs"), isActive: $showProfileEditScreen) {
                        Button {
                            showProfileEditScreen.toggle()
                        } label: {
                            HStack {
                                Text("Edit Profile")
                                Spacer()
                            }
                        }
                    }
                }
                .foregroundStyle(.black)
                
                Picker("Language", selection: $selectedLanguage) {
                    Text("🇷🇺 Russian")
                        .tag(0)
                    Text("🇺🇸 English")
                        .tag(1)
                    Text("🇰🇿 Kazakh")
                        .tag(2)
                }
                .pickerStyle(.inline)
                
                Section("Other") {
                    
                    if email == "admin@gmail.com" {
                        NavigationLink(destination: AdminScreen(), isActive: $showAdminScreen) {
                            Button {
                                showAdminScreen.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "person.badge.key.fill")
                                    Text("Admin")
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("Help")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    
                    Button {
                        try? AuthService.shared.logout()
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Log out")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .foregroundStyle(.black)
                .navigationTitle("Settings")
            }
        }
    }
    
}
#Preview {
    SettingsScreen()
}
