//
//  PostList.swift
//  Jina
//
//  Created by Schannikov Timothy on 10.04.2024.
//

import SwiftUI

struct PostList: View {
    @Binding var models: [TrashModel]
    @State private var showingAlert: Bool = false

    var body: some View {
        ScrollView {
            if !models.isEmpty {
                LazyVStack {
                    ForEach(models) { model in
                        PostElement(model: model, buttonTitle: "Take it") {
                            Task {
                                let user = try await DatabaseService.shared.getCurrentUserModel()

                                if !user.trashModelId.isEmpty {
                                    showingAlert.toggle()
                                } else {
                                    DatabaseService.shared.setStatus(for: model.id, status: .inProgress)
                                    try DatabaseService.shared.setUserTrashItem(for: model.id)
                                    try DatabaseService.shared.setReporterForTrashItem(id: model.id)

                                    if let index = models.firstIndex(where: { $0.id == model.id }) {
                                        models.remove(at: index)
                                    }
                                }
                            }

                        }
                    }
                }
                .alert("You already have a job", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
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
