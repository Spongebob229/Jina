//
//  GettingDataStatus.swift
//  Jina
//
//  Created by Schannikov Timothy on 21.04.2024.
//

import Foundation

enum GettingDataStatus: Equatable {
    case loading
    case data([TrashModel])
    case error(Error)
    
    static func == (lhs: GettingDataStatus, rhs: GettingDataStatus) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.data, .data):
            return true
        case (.error, .error):            
            return true
        default:
            return false
        }
    }
}
