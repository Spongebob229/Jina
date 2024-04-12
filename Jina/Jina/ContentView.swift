//
//  ContentView.swift
//  Jina
//
//  Created by Schannikov Timothy on 07.04.2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var body: some View{
        VStack {
            TabView {
               PostList()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                PostCreationScreen()
                    .tabItem {
                        Label("Add", systemImage: "plus.circle")
                    }
                ProfileScreen()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
