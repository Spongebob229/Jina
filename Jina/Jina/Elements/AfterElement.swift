//
//  AfterElement.swift
//  Jina
//
//  Created by Schannikov Timothy on 22.04.2024.
//

import SwiftUI

struct AfterElement: View {
    let model: TrashModel
    @Binding var url: URL?
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
                    .frame(width: 200, height: 150)
            }

            VStack(alignment: .leading, spacing: 8) {
                
                Text("📃 \(model.descriptionAfter)")
                    .font(.system(size: 14))
                
                Spacer()
            }
            .padding(.horizontal, 8)
    
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 150)
    }
}

