//
//  PostCreationScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 11.04.2024.
//

import SwiftUI
import PhotosUI
import Capture

struct PostCreationScreen: View {
    @State private var trashItem: PhotosPickerItem?
    @State private var trashUIImage = UIImage(systemName: "photo.on.rectangle")
    @State private var pictureHeight: CGFloat = 50.0
    @State private var imageData: Data?
    @State private var address: String = ""
    @State private var description: String = ""
    @State private var isActionSheetPresented: Bool = false
    @State private var isNeedToShowPhotoPicker: Bool = false
    @State private var showingSheet: Bool = false
    @State private var showingAlert: Bool = false
    @State private var outputPhoto: UIImage?
    @State private var imageSize: ImageSize = .small
    @FocusState private var isFocused: Bool
    @Binding var selectedTab: Int

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Add your trash")
                    .font(.system(size: 40, weight: .semibold))
                    .padding(.top, 8)
                Text("Add photo")
                    .font(.system(size: 25))
                
                
                    ZStack {
                        Image(uiImage: trashUIImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .frame(height: pictureHeight)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .background(Color.textField)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                            .foregroundColor(Color.blue) // Change the color as needed
                    )
                    .onTapGesture {
                        isActionSheetPresented.toggle()
                }
                
                Text("Address:")
                    .font(.system(size: 25))
                
                InputField(text: $address, placeholder: "Address")
                
                Text("Description:")
                    .font(.system(size: 25))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.textField)
                    TextEditor(text: $description)
                        .padding(.leading, 16)
                        .scrollContentBackground(.hidden)
                        .onChange(of: description) { _ in
                                            if description.last?.isNewline == .some(true) {
                                                description.removeLast()
                                                isFocused = false
                                            }
                                        }
                                        .focused($isFocused)
                                        .submitLabel(.done)
                }
                .frame(height: 100)
                
                MainButton(title: "Create order") {
                    guard let imageData else { return }
                    
                    let id = UUID().uuidString
                    Task {
                        do {
                            let userModel = try await DatabaseService.shared.getCurrentUserModel()
                            let trashModel = TrashModel(id: id,
                                                        author: userModel.name + " " + userModel.surname,
                                                        reporter: "",
                                                        address: address,
                                                        descriptionBefore: description,
                                                        descriptionAfter: "",
                                                        status: TrashStatus.open.rawValue,
                                                        stars: 0)
                            
                            StorageService.shared.uploadImage(imageData, name: id, to: TrashItemConditions.before.rawValue)
                            try DatabaseService.shared.createTrashItemDocument(trashItem: trashModel)
                            clearScreen()
                            showingAlert.toggle()
                            selectedTab = 0
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
                        trashUIImage = uiImage
                    } else {
                        print("Failed")
                    }
                }
            }
            .onChange(of: trashUIImage) {
                imageData = trashUIImage?.jpegData(compressionQuality: 0.25)
                if trashUIImage == UIImage(systemName: "photo.on.rectangle") {
                    imageSize = .small
                }
                else {
                    imageSize = .big
                }
            }
            .onChange(of: imageSize){
                if imageSize == .big {
                    pictureHeight = 180.0
                }
                else {
                    pictureHeight = 50.0
                }
                    
            }
            .confirmationDialog("Select a color", isPresented: $isActionSheetPresented, titleVisibility: .hidden) {
                Button("Choose from galery") {
                    isNeedToShowPhotoPicker.toggle()
                }
                Button("Take a photo") {
                    showingSheet.toggle()
                }
            }
            .photosPicker(isPresented: $isNeedToShowPhotoPicker, selection: $trashItem)
            .fullScreenCover(isPresented: $showingSheet) {
                ImagePicker(uiImage: $trashUIImage, imageSize: $imageSize)
                    .ignoresSafeArea()
        }
        }
        .alert("Your post will appear in main list after moderation :)", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        
        
    }
    
    private func clearScreen() {
        address = ""
        description = ""
        trashUIImage = UIImage(systemName: "photo.on.rectangle")
        imageSize = .small
    }
}



