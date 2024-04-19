//
//  ProfileScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 11.04.2024.
//

import SwiftUI

struct ProfileScreen: View {
    @Binding var userModel: UserModel?
    let trashModel: TrashModel?
    let email: String = AuthService.shared.user?.email ?? "go fuck yourself"
    
    var body: some View {
        VStack(spacing: 0) {
            Button("Logout") {
               try? AuthService.shared.logout()
            }
            Image(systemName: "person.circle.fill")
                .resizable() // Make the image resizable
                .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                .padding(.top, 45)
                .padding(.bottom, 20)
                .frame(width: 120, height: 120) // Set the width and height to 120
            Text("\(userModel?.name ?? "") \(userModel?.surname ?? "")")
                .font(.system(size: 25, weight: .semibold))
                .foregroundStyle(.black)
                .padding(.bottom, 8)
            Text("\(email)")
                .font(.system(size: 16, weight: .semibold))
                .tint(.gray)
                .foregroundColor(.gray)
                .textSelection(.disabled)
                .padding(.bottom, 24)
            StatisticsPanel(userModel: $userModel)
                .padding(.bottom, 16)
            HStack {
                Text("In progress:")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .padding(.bottom, 24)
                    
                Spacer()
            }
            
           
            if let trashModel {
                PostElement(model: trashModel, buttonTitle: "To check") {
                    
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray, lineWidth: 3)
                )
            }
                
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}


/**
 VStack {
     Button("Logout") {
        try? AuthService.shared.logout()
     }
     

     ScrollView {
         if !models.isEmpty {
             LazyVStack {
                 ForEach($models) { model in
                     PostElement(model: model) {}
                 }
             }
             .background(Color.textField)
         }
     }
     .padding(.top, 1)
 
 #Preview {
     ProfileScreen(models: .constant([TrashModel]()))
 }

 }
 */
