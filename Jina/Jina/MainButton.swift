//
//  MainButton.swift
//  Jina
//
//  Created by Schannikov Timothy on 08.04.2024.
//

import SwiftUI

struct MainButton: View {
    let title: String
    let onButtonPressed: (() -> Void)?
    
    var body: some View {
        Button {
            onButtonPressed?()
        } label: {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

#Preview {
    MainButton(title: "Helo", onButtonPressed: {})
}
