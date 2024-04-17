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
            HStack {
                Text(model.author)
                    .padding(.leading, 16)
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                
                Text("\(model.stars) ⭐️")
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
                    
                    Text("📃 \(model.description)")
                        .font(.system(size: 14))
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
        
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 150)
            
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
                    url = try await StorageService.shared.imageURL(for: model.image)
                } catch {
                    print(error.localizedDescription)
                }

            }
        }
    }
}
