//
//  TrashReviewScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 21.04.2024.
//

import SwiftUI

struct TrashReviewScreen: View {
    @Binding var models: [TrashModel]
    
    var body: some View {
        ScrollView {
            if !models.isEmpty {
                LazyVStack {
                    ForEach(models) { model in
                        ReviewCheckElement(model: model) {
                            DatabaseService.shared.setStatus(for: model.id, status: .open)
                            try? DatabaseService.shared.cleanReporterForTrashItem(id: model.id)
                            delete(by: model.id)
                            
                        } onApplyButtonPressed: {
                            Task {
                                try await DatabaseService.shared.addPoints(for: model.reporter, points: model.stars)
                                try await DatabaseService.shared.increseCleaned(for: model.reporter)
                                DatabaseService.shared.deleteTrashItem(for: model.id)
                                delete(by: model.id)
                            }
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


