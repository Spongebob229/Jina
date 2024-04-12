//
//  CreateOrderView.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 09.04.2024.
//

import SwiftUI
import PhotosUI

struct CreateOrderView: View {
    @State private var trashItem: PhotosPickerItem?
    @State private var trashImage: Image = Image("tiger")
    @State private var imageData: Data?
    @State private var address: String = ""
    @State private var description: String = ""

       var body: some View {
           VStack(spacing: 16) {
               PhotosPicker(selection: $trashItem) {
                   Image("smile")
                       .resizable()
                       .scaledToFill()
                       .frame(width: 50, height: 50)
               }

               trashImage
                   .resizable()
                   .scaledToFit()
                   .frame(width: 300, height: 300)
               
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
                       } catch {
                           print(error.localizedDescription)
                       }
                   }
               }
           }
           .padding(.horizontal, 16)
           .onChange(of: trashItem) {
               Task {
                   if let imageData = try? await trashItem?.loadTransferable(type: Data.self),
                      let uiImage = UIImage(data: imageData) {
                       trashImage = Image(uiImage: uiImage)
                       self.imageData = uiImage.jpegData(compressionQuality: 0.3)

                   } else {
                       print("Failed")
                   }
               }
           }
       }


}

#Preview {
    CreateOrderView()
}
