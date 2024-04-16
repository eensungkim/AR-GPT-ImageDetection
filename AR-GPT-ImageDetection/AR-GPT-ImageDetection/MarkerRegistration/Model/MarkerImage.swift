//
//  MarkerImage.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

struct MarkerImage {
    enum ImageType {
        case qrCode
        case text
        case logo
        case image2D
        case realObject
    }
    
    let id = UUID()
    let name: String
    let type: ImageType
    let data: Data
    let description: String
    let additionalInformation: String
}
