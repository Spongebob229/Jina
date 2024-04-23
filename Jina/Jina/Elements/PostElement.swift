//
//  PostElement.swift
//  Jina
//
//  Created by Schannikov Timothy on 09.04.2024.
//

import SwiftUI
import SDWebImage

struct PostElement: View {
    let model: TrashModel
    @State var url: URL?
    
    let buttonTitle: String
    var onButtonPressed: (() -> Void)
    
    var body: some View {
        VStack(spacing: 16) {
            BaseElement(condition: .before, model: model, url: $url)
            
            MainButton(title: buttonTitle) {
                    onButtonPressed()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
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
