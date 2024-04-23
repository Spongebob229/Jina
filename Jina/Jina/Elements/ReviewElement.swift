//
//  ReviewElement.swift
//  Jina
//
//  Created by Schannikov Timothy on 19.04.2024.
//

import SwiftUI
import SDWebImage

struct ReviewElement: View {
    let model: TrashModel
    @State var url: URL?

    var body: some View {
        VStack(spacing: 16) {
            BaseElement(condition: .after, model: model, url: $url)
        }
        .background(Color.white)
        .cornerRadius(8)
        .onAppear {
            Task {
                do {
                    url = try await StorageService.shared.imageURL(for: model.id, storage: .after)
                } catch {
                    print(error.localizedDescription)
                }

            }
        }
    }
}

