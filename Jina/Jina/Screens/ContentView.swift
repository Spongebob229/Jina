//
//  ContentView.swift
//  Jina
//
//  Created by Schannikov Timothy on 07.04.2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var models = [TrashModel]()
    @State private var profileModels = [TrashModel]()
    @State private var onReviewModels = [TrashModel]()
    @State private var userModel: UserModel?
    @State private var selectedTab = 0
    @State private var trashModel: TrashModel?
    @State private var error: Error?

    var body: some View{
        VStack {
            TabView(selection: $selectedTab) {
                PostList(models: $models)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                    .onAppear {
                        Task {
                            do {
                                models = try await DatabaseService.shared.getMainList()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                PostCreationScreen(selectedTab: $selectedTab)
                    .tabItem {
                        Label("Add", systemImage: "plus.circle")
                    }
                    .tag(1)
                ProfileScreen(error: $error, trashModel: $trashModel, userModel: $userModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(2)
                    .onAppear {
                        Task {
                            do {
                                userModel = try await DatabaseService.shared.getCurrentUserModel()
                                if let userModel {
                                    trashModel = try await DatabaseService.shared.getCurrentTrash(id: userModel.trashModelId)
                                }
                            } catch {
                                self.error = error
                                trashModel = nil
                            }
                        }
                    }
            }

        }
    }
}


