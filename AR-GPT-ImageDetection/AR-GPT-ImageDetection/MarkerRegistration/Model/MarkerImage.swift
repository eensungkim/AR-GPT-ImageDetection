//
//  MarkerImage.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

struct MarkerImage {
    enum ImageType: String {
        case qrCode = "qrCode"
        case text = "text"
        case logo = "logo"
        case image2D = "image2D"
        case realObject = "realObject"
    }
    
    let id: UUID
    let name: String
    let type: ImageType
    let data: Data?
    let description: String
    let additionalInformation: String
    
    init(
        id: UUID,
        name: String,
        type: ImageType,
        data: Data?,
        description: String,
        additionalInformation: String
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.data = data
        self.description = description
        self.additionalInformation = additionalInformation
    }
    
    init(
        id: UUID,
        name: String,
        type: String,
        data: String?,
        description: String,
        additionalInformation: String
    ) {
        self.id = id
        self.name = name
        self.type = ImageType(from: type)
        
        if let dataString = data {
            self.data = Data(base64Encoded: dataString)
        } else {
            self.data = nil
        }
        self.description = description
        self.additionalInformation = additionalInformation
    }
}

extension MarkerImage.ImageType {
    init(from string: String) {
        switch string.lowercased() {  // 소문자 비교
        case "qrcode":
            self = .qrCode
        case "text":
            self = .text
        case "logo":
            self = .logo
        case "image2d":
            self = .image2D
        case "realobject":
            self = .realObject
        default:
            fatalError("Unknown ImageType: \(string)")
        }
    }
}
