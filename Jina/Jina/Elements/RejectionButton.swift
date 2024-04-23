//
//  RejectionButton.swift
//  Jina
//
//  Created by Schannikov Timothy on 22.04.2024.
//

import SwiftUI

struct RejectionButton: View {
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
                .background(Color.red)
                .cornerRadius(8)
        }
    }
}

