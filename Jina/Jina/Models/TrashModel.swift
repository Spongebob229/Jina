//
//  TrashModel.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 11.04.2024.
//

import Foundation

struct TrashModel: Codable, Identifiable {
    let id: String
    let author: String
    let reporter: String
    let address: String
    let descriptionBefore: String
    let descriptionAfter: String
    let status: String
    let stars: Int
}
