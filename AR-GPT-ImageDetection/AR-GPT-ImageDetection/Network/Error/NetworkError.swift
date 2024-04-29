//
//  NetworkError.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidURLResponse
    case invalidStatusCode(Int)
    
    private var _errorDescription: String {
        return "일시적인 네트워크 에러가 발생했습니다. 다시 시도해 주세요."
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidURL, .invalidURLResponse, .invalidStatusCode(_):
            return NSLocalizedString(_errorDescription, comment: "NetworkError")
        }
    }
}
