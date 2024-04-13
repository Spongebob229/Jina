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

    var body: some View{
        VStack {
            TabView {
                PostList(models: $models)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .onAppear {
                        Task {
                            do {
                                models = try await DatabaseService.shared.getMainListItems()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                PostCreationScreen()
                    .tabItem {
                        Label("Add", systemImage: "plus.circle")
                    }
                ProfileScreen(models: $profileModels)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .onAppear {
                        Task {
                            do {
                                profileModels = try await DatabaseService.shared.getUserListModels()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }

            }

        }
    }
}

#Preview {
    ContentView()
}
