//
//  PostList.swift
//  Jina
//
//  Created by Schannikov Timothy on 10.04.2024.
//

import SwiftUI

struct PostList: View {
    @Binding var models: [TrashModel]

    var body: some View {
        ScrollView {
            if !models.isEmpty {
                LazyVStack {
                    ForEach($models) { model in
                        PostElement(model: model) {
                            DatabaseService.shared.setStatus(for: model.id)
                            DatabaseService.shared.setResponsible(for: model.id)

                            if let index = models.firstIndex(where: { $0.id == model.id }) {
                                models.remove(at: index)
                            }
                        }
                    }
                }
                .background(Color.textField)
            }
        }
        .padding(.top, 1)
    }
}

//#Preview {
//    PostList(models: $)
//}
