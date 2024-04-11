//
//  CreateOrderView.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 09.04.2024.
//

import SwiftUI
import PhotosUI

struct CreateOrderView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image = Image("tiger")

       var body: some View {
           VStack {
               PhotosPicker(selection: $avatarItem) {
                   Image("smile")
                       .resizable()
                       .scaledToFill()
                       .frame(width: 50, height: 50)
               }

               avatarImage
                   .resizable()
                   .scaledToFit()
                   .frame(width: 300, height: 300)
           }
           .onChange(of: avatarItem) {
               Task {
                   if let imageData = try? await avatarItem?.loadTransferable(type: Data.self),
                      let uiImage = UIImage(data: imageData) {
                       avatarImage = Image(uiImage: uiImage)

                       
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
