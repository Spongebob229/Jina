//
//  MainTitle.swift
//  Jina
//
//  Created by Schannikov Timothy on 08.04.2024.
//

import SwiftUI


struct MainTitle: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 70, weight: .bold))
            .multilineTextAlignment(.leading)
            .foregroundColor(color)
    }
}

#Preview {
    MainTitle(title:"Welcome to Jina", color: Color.black)
}

