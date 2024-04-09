//
//  InputField.swift
//  Jina
//
//  Created by Schannikov Timothy on 08.04.2024.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.textField)
                .frame(height: 46)
            TextField(placeholder, text: $text)
                .padding(.leading, 16)

        }
    }
}

struct SecureInputField: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.textField)
                .frame(height: 46)
            SecureField("Password", text: $text)
                .padding(.leading, 16)
        }
    }
}

