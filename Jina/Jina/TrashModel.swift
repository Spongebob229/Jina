//
//  TrashModel.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 11.04.2024.
//

import Foundation

struct TrashModel: Codable {
    let id: String
    let author: String
    let imageId: String
    let address: String
    let description: String
    let status: String
    let stars: Int
}
