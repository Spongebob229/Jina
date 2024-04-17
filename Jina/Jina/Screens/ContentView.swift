//
//  ContentView.swift
//  Jina
//
//  Created by Schannikov Timothy on 07.04.2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var models = [TrashModel]()
    @State var profileModels = [TrashModel]()
    @State var userModel: UserModel?
    @State var selectedTab = 0
    @State private var trashModel: TrashModel?

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
                                models = try await DatabaseService.shared.getMainListItems()
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
                ProfileScreen(userModel: $userModel, trashModel: trashModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(2)
                    .onAppear {
                        Task {
                            do {
                                userModel = try await DatabaseService.shared.getCurrentUserModel()
                                
                                if let userModel, !userModel.trashModelId.isEmpty {
                                    trashModel = try await DatabaseService.shared.getUserListModels(id: userModel.trashModelId)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
            }

        }
    }
}


