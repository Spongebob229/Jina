//
//  PostCreationScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 11.04.2024.
//

import SwiftUI

struct PostCreationScreen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Add your trash")
                .font(.system(size: 40, weight: .semibold))
            Text("Add photo")
                .font(.system(size: 25))
            ZStack() {
                Button {
                    
                } label: {
                    Text("PHOTO")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            
            
            .frame(width: 300, height: 225)
            
            .background(Color.blue.opacity(0.2))
            .border(Color.blue)
            .cornerRadius(8)
            
            
        }
    }
}

#Preview {
    PostCreationScreen()
}
