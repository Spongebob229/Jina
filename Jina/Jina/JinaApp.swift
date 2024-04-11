//
//  JinaApp.swift
//  Jina
//
//  Created by Schannikov Timothy on 07.04.2024.
//

import Firebase
import SwiftUI

@main
struct JinaApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
//            WelcomeScreen()
            CreateOrderView()
//            PostList()
        }
    }
}
