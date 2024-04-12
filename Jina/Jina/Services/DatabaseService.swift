//
//  DatabaseService.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 11.04.2024.
//

import FirebaseFirestore

final class DatabaseService {
    static let shared = DatabaseService()



    private init() {}

    private let dataBase = Firestore.firestore()

    private var usersCollectionReference: CollectionReference {
        dataBase.collection("users")
    }

    private var itemsCollectionReference: CollectionReference {
        dataBase.collection("trashItems")
    }

    func createUserDocument(user: UserModel) throws {
        try usersCollectionReference.document(user.id).setData(from: user)
    }

    func createTrashItemDocument(trashItem: TrashModel) throws {
        try itemsCollectionReference.document(trashItem.id).setData(from: trashItem)
    }

    func getCurrentUserModel() async throws -> UserModel {
        guard let id = AuthService.shared.user?.uid else { throw Errors.userIdError }

        return try await usersCollectionReference.document(id).getDocument(as: UserModel.self)
    }
}
