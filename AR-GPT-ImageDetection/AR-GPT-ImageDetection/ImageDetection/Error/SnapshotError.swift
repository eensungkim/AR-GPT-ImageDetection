//
//  SnapshotError.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/26/24.
//

import Foundation

enum SnapshotError: LocalizedError {
    case cgImageConversionFailure
    case cropFailure
    
    private var _errorDescription: String {
        return "스냅샷 생성에 실패했습니다. 다시 시도해 주세요."
    }
    
    var errorDescription: String? {
        switch self {
        case .cgImageConversionFailure, .cropFailure:
            return NSLocalizedString(_errorDescription, comment: "SnapshotError")
        }
    }
}
