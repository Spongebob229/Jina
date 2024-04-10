//
//  PostElement.swift
//  Jina
//
//  Created by Schannikov Timothy on 09.04.2024.
//

import SwiftUI

struct PostElement: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Тимон Пумбович")
                    .padding(.leading, 16)
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                
                Text("100 ⭐️")
                    .padding(.trailing, 16)
                    .font(.system(size: 17, weight: .semibold))
            }
            .padding(.top, 16)
            
            HStack(spacing: 0) {
                Image("Kaka")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("📌 Орбита 1, Дом 3, Квартира 107, переулок 10")
                        .font(.system(size: 14))
                    
                    Text("📃 Эу джиги нада убраться а то чего грязно)")
                        .font(.system(size: 14))
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
        
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 150)
            
            MainButton(title: "Take it") {
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(8)
        
    }
}


#Preview {
    PostElement()
}
