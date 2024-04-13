//
//  ProfileScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 11.04.2024.
//

import SwiftUI

struct ProfileScreen: View {
    @Binding var models: [TrashModel]

    var body: some View {

        VStack {
            Button("Logout") {
               try? AuthService.shared.logout()
            }

            ScrollView {
                if !models.isEmpty {
                    LazyVStack {
                        ForEach($models) { model in
                            PostElement(model: model) {}
                        }
                    }
                    .background(Color.textField)
                }
            }
            .padding(.top, 1)
        }
    }
}

#Preview {
    ProfileScreen(models: .constant([TrashModel]()))
}
