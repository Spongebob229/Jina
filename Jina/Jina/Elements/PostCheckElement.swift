//
//  PostCheckElement.swift
//  Jina
//
//  Created by Schannikov Timothy on 21.04.2024.
//

import SwiftUI

struct PostCheckElement: View {
    let model: TrashModel
    @State var url: URL?
    @State var stars = ""
    
    var onDeleteModel: () -> Void
    
    var body: some View {
        VStack() {
            BaseElement(condition: .before, model: model, url: $url)
            
            InputField(text: $stars, placeholder: "Edit number of stars")
                .keyboardType(.numberPad)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
            HStack {
                RejectionButton(title: "Delete post") {
                    DatabaseService.shared.deleteTrashItem(for: model.id)
                    onDeleteModel()
                }
                .foregroundColor(.red)
                
                MainButton(title: "Apply changes") {
                    Task {
                        DatabaseService.shared.setStars(for: model.id, stars: Int(stars) ?? 0)
                        onDeleteModel()
                    }
                }
            }
            .padding(.horizontal, 16)
            
        }
        .background(Color.white)
        .cornerRadius(8)
        .onAppear {
            Task {
                do {
                    url = try await StorageService.shared.imageURL(for: model.id, storage: .before)
                } catch {
                    print(error.localizedDescription)
                }

            }
        }
    }
}


