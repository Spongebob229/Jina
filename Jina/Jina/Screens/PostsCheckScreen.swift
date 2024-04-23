//
//  PostsCheckScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 21.04.2024.
//

import SwiftUI

struct PostsCheckScreen: View {
    @Binding var models: [TrashModel]
    
    var body: some View {
        ScrollView {
            if !models.isEmpty {
                LazyVStack {
                    ForEach(models) { model in
                        PostCheckElement(model: model) {
                            delete(by: model.id)
                        }
                    }
                }
                .background(Color.textField)
            }
        }
        .padding(.top, 1)
    }
    
    private func delete(by id: String) {
        guard let index = models.firstIndex(where: { $0.id == id }) else { return }

        models.remove(at: index)
    }
}

