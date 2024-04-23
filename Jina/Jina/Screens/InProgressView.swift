//
//  InProgressView.swift
//  Jina
//
//  Created by Schannikov Timothy on 21.04.2024.
//

import SwiftUI

struct InProgressView: View {
    @Binding var showOnCheckScreen: Bool
    @Binding  var model: TrashModel?
    @Binding var error: Error?
    
    var body: some View {
        if let model {
            PostElement(model: model, buttonTitle: "On check") {
                showOnCheckScreen.toggle()
            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 3)
                )            
        } else if let error = error as? CustomErrors {
            Text(error.localizedDescription)
        }
    }
        
}

