//
//  EditProfileScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 21.04.2024.
//

import SwiftUI

struct EditProfileScreen: View {
    @State var name: String
    @State var surname: String
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 45)
                .padding(.bottom, 20)
                .frame(width: 120, height: 120)
            InputField(text: $name, placeholder: "Enter new name")
            InputField(text: $surname, placeholder: "Enter new surname")
            Spacer()
            MainButton(title: "Apply changes", onButtonPressed: {})
        }
        .padding(.horizontal, 16)
        
    }
}

#Preview {
    EditProfileScreen(name: "Bob", surname: "Skubi")
}
