//
//  StorageService.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 11.04.2024.
//

import Foundation
import FirebaseStorage
import SwiftUI

struct StorageService {
    static let shared = StorageService()

    private init() {}

    private let storage = Storage.storage()

    private var imagesReference: StorageReference {
        storage.reference()
    }

    func imageURL(for name: String) async throws -> URL {
        try await imagesReference.child("images/\(name)").downloadURL()
    }

    func uploadImage(_ imageData: Data, name: String) {
        imagesReference.child("images/\(name)").putData(imageData)
    }
}
