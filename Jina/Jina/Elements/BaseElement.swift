//
//  BaseElement.swift
//  Jina
//
//  Created by Schannikov Timothy on 19.04.2024.
//

import SwiftUI

struct BaseElement: View {
    let condition: TrashItemConditions
    let model: TrashModel
    @Binding var url: URL?
    
    var body: some View {
        HStack {
            Text(model.author)
                .padding(.leading, 16)
                .font(.system(size: 17, weight: .semibold))
            Spacer()
            
            Text("\(model.stars) 💎")
                .padding(.trailing, 16)
                .font(.system(size: 17, weight: .semibold))
        }
        .padding(.top, 16)
        
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
                Text("📌 \(model.address)")
                    .font(.system(size: 14))
                
                if condition == .before {
                    Text("📃 \(model.descriptionBefore)")
                        .font(.system(size: 14))
                }
                
                if condition == .after {
                    Text("📃 \(model.descriptionAfter)")
                        .font(.system(size: 14))
                }
                
                
                
                Spacer()
            }
            .padding(.horizontal, 8)
    
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 150)
    }
}


