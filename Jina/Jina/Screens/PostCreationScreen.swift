//
//  PostCreationScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 11.04.2024.
//

import SwiftUI
import PhotosUI

struct PostCreationScreen: View {
    @State private var trashItem: PhotosPickerItem?
    @State private var trashImage = Image(systemName: "photo.on.rectangle")
    @State private var imageData: Data?
    @State private var address: String = ""
    @State private var description: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Add your trash")
                .font(.system(size: 40, weight: .semibold))
            Text("Add photo")
                .font(.system(size: 25))

            PhotosPicker(selection: $trashItem) {
                trashImage
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(height: 300)
                    .padding(.horizontal)
            }
            .background(.textField)
            .cornerRadius(8)

            InputField(text: $address, placeholder: "Address")
            InputField(text: $description, placeholder: "Description")
            MainButton(title: "Create order") {
                guard let imageData else { return }

                let id = UUID().uuidString
                Task {
                    do {
                        let userModel = try await DatabaseService.shared.getCurrentUserModel()
                        let trashModel = TrashModel(id: id,
                                                    author: userModel.name + " " + userModel.surname,
                                                    image: id,
                                                    address: address,
                                                    description: description,
                                                    status: "Open",
                                                    stars: 0)

                        StorageService.shared.uploadImage(imageData, name: id)
                        try DatabaseService.shared.createTrashItemDocument(trashItem: trashModel)
                        clearScreen()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal)
        .onChange(of: trashItem) {
            Task {
                if let data = try? await trashItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    trashImage = Image(uiImage: uiImage)
                    imageData = uiImage.jpegData(compressionQuality: 0.3)
                } else {
                    print("Failed")
                }
            }
        }
    }

    private func clearScreen() {
        address = ""
        description = ""
        trashImage = Image(systemName: "photo.on.rectangle")
    }
}

#Preview {
    PostCreationScreen()
}
