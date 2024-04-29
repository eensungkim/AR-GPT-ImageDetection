//
//  ImageError.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/29/24.
//

import Foundation

enum ImageError: LocalizedError {
    case conversionFailure
    
    private var _errorDescription: String {
        "이미지 변환에 실패했습니다. 다시 시도해 주세요."
    }
    
    var errorDescription: String? {
        switch self {
        case .conversionFailure:
            return NSLocalizedString(_errorDescription, comment: "Image Conversion Failure")
        }
    }
}
