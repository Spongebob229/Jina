//
//  UserModel.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 11.04.2024.
//

import Foundation

struct UserModel: Codable {
    var id: String
    let trashModelId: String
    let stars: Int
    let completed: Int
    let posted: Int
    let name: String
    let surname: String
}
