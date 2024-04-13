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

    private var userId: String? {
        AuthService.shared.user?.uid
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

    func getMainListItems() async throws -> [TrashModel] {
        try await itemsCollectionReference
            .whereField("status", isEqualTo: "Open")
            .getDocuments()
            .documents.map { try $0.data(as: TrashModel.self) }
    }

    func getUserListModels() async throws -> [TrashModel] {
        try await itemsCollectionReference
            .whereField("responsible", isEqualTo: userId as Any)
            .getDocuments()
            .documents.map { try $0.data(as: TrashModel.self) }
    }

    func setStatus(for id: String) {
        itemsCollectionReference
            .document(id)
            .updateData(["status": "inProgress"])
    }

    func setResponsible(for id: String) {
        guard let userId else { return }

        itemsCollectionReference
            .document(id)
            .updateData(["responsible": userId])
    }
}
