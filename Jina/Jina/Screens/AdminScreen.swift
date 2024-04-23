//
//  AdminScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 21.04.2024.
//

import SwiftUI

struct AdminScreen: View {
    @State private var selectedTab = 0
    @State private var mainModels = [TrashModel]()
    @State private var reviewModels = [TrashModel]()
    

    var body: some View {
        TabView(selection: $selectedTab) {
            PostsCheckScreen(models: $mainModels)
                .tabItem {
                    Label("Posts check", systemImage: "square.and.arrow.up")
                }
                .onAppear {
                    Task {
                        do {
                            mainModels = try await DatabaseService.shared.getAdminListItems(for: .open)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                .tag(0)
            TrashReviewScreen(models: $reviewModels)
                .tabItem {
                    Label("Trash review", systemImage: "exclamationmark.shield.fill")
                }
                .onAppear {
                    Task {
                        do {
                            reviewModels = try await DatabaseService.shared.getModerationList()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                .tag(1)
            
        }
    }
}

#Preview {
    AdminScreen()
}
