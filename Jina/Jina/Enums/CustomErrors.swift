//
//  NetworkError.swift
//  Jina
//
//  Created by Vasiliy Shannikov on 12.04.2024.
//

import Foundation

enum CustomErrors: Error {
    case userIdError
    case fetchPictureError
    case trashIdError
    
    var localizedDescription: String {
        switch self {
        case .userIdError:
            return "3oimoitmviotr"
        case .fetchPictureError:
            return "5vtvj wkjv"
        case .trashIdError:
            return "Thire is no active task yet"
        }
    }
}
