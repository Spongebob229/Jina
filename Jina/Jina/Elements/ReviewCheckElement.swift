//
//  ReviewCheckModel.swift
//  Jina
//
//  Created by Schannikov Timothy on 22.04.2024.
//

import SwiftUI

struct ReviewCheckElement: View {
    let model: TrashModel
    @State var urlBefore: URL?
    @State var urlAfter: URL?
    @State var stars = ""
    var onRejectButtonPressed: (() -> Void)
    var onApplyButtonPressed: (() -> Void)
    
    
    var body: some View {
        VStack() {
            BaseElement(condition: .before, model: model, url: $urlBefore)
            
            HStack {
                Image(systemName: "arrow.down")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 106)
                Spacer()
            }
            
            
            AfterElement(model: model, url: $urlAfter)

            HStack {
                MainButton(title: "All nice") {
                    onApplyButtonPressed()
                }
                
                RejectionButton(title: "Return") {
                    onRejectButtonPressed()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            
        }
        .background(Color.white)
        .cornerRadius(8)
        .onAppear {
            Task {
                do {
                    async let urlBefore = StorageService.shared.imageURL(for: model.id, storage: .before)
                    async let urlAfter = StorageService.shared.imageURL(for: model.id, storage: .after)
                    self.urlBefore = try await urlBefore
                    self.urlAfter = try await urlAfter
                } catch {
                    print(error.localizedDescription)
                }

            }
        }
    }
}

