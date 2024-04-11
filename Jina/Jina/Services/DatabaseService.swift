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

    func createUserDocument(user: UserModel) throws {
        try usersCollectionReference.document(user.id).setData(from: user)
    }
}
