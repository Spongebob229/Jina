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
    
    private var itemsAfterCollectionReference: CollectionReference {
        dataBase.collection("trashAfterItems")
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
        guard let id = AuthService.shared.user?.uid else { throw CustomErrors.userIdError }

        return try await usersCollectionReference.document(id).getDocument(as: UserModel.self)
    }

    func getAdminListItems(for trashStatus: TrashStatus) async throws -> [TrashModel] {
        try await itemsCollectionReference
            .whereField("status", isEqualTo: trashStatus.rawValue)
            .getDocuments()
            .documents.map { try $0.data(as: TrashModel.self) }
    }
    
    func getListUserItems(for trashStatus: TrashStatus) async throws -> [TrashModel] {
        try await itemsCollectionReference
            .whereField("status", isEqualTo:trashStatus.rawValue)
            .getDocuments()
            .documents.map { try $0.data(as: TrashModel.self) }
            .filter { $0.reporter == userId }
    }
    
    func getMainList() async throws -> [TrashModel] {
        try await itemsCollectionReference
            .whereField("status", isEqualTo: TrashStatus.open.rawValue)
            .getDocuments()
            .documents.map { try $0.data(as: TrashModel.self) }
            .filter { $0.stars > 0 }
    }
    
    func getModerationList() async throws -> [TrashModel] {
        try await itemsCollectionReference
            .whereField("status", isEqualTo: TrashStatus.open.rawValue)
            .getDocuments()
            .documents.map { try $0.data(as: TrashModel.self) }
            .filter { $0.stars == 0 }
    }

    func getCurrentTrash(id: String) async throws -> TrashModel {
        guard !id.isEmpty else { throw CustomErrors.trashIdError }
        
        return try await itemsCollectionReference
            .document(id)
            .getDocument(as: TrashModel.self)
    }
    
    func setReporterForTrashItem(id: String) throws {
        guard !id.isEmpty else { throw CustomErrors.trashIdError }
        
        itemsCollectionReference
            .document(id)
            .updateData(["reporter": userId ?? ""])
    }
    
    func cleanReporterForTrashItem(id: String) throws {
        guard !id.isEmpty else { throw CustomErrors.trashIdError }
        
        itemsCollectionReference
            .document(id)
            .updateData(["reporter": ""])
    }
    

    func setStatus(for id: String, status: TrashStatus) {
        itemsCollectionReference
            .document(id)
            .updateData(["status": status.rawValue])
    }
    
    func setStars(for id: String, stars: Int) {
        itemsCollectionReference
            .document(id)
            .updateData(["stars": stars])
    }

    func setUserTrashItem(for id: String) throws {
        guard let userId else { throw CustomErrors.userIdError }

        usersCollectionReference
            .document(userId)
            .updateData(["trashModelId": id])
    }
    
    func removeTrashItemFromInProgress() async throws {
        guard let userId else { throw CustomErrors.userIdError }
        
        try await usersCollectionReference
            .document(userId)
            .updateData(["trashModelId": ""])
    }

    func setDescription(for id: String, description: String) {
        itemsCollectionReference
            .document(id)
            .updateData(["descriptionAfter": description])
    }
    
    func addPoints(for userId: String, points: Int) async throws {
        let userDoc = usersCollectionReference.document(userId)
        
        if let stars = try await userDoc.getDocument().data()?["stars"] as? Int {
            try await userDoc.updateData(["stars": stars + points])
        }
    }
    
    func increseCleaned(for userId: String) async throws {
        let userDoc = usersCollectionReference.document(userId)
        
        if let cleaned = try await userDoc.getDocument().data()?["completed"] as? Int {
            try await userDoc.updateData(["completed": cleaned + 1])
        }
    }
    
    func deleteTrashItem(for id: String) {
        itemsCollectionReference
            .document(id)
            .delete()
    }
}
