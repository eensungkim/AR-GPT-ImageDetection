//
//  NetworkError.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/17/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidURLResponse
    case invalidStatusCode(Int)
}
