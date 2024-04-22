//
//  MarkerImage.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

struct MarkerImage {
    let id: UUID
    let name: String
    let data: Data?
    let description: String
    let additionalInformation: String
    
    init(
        id: UUID,
        name: String,
        data: Data?,
        description: String,
        additionalInformation: String
    ) {
        self.id = id
        self.name = name
        self.data = data
        self.description = description
        self.additionalInformation = additionalInformation
    }
    
    init(
        id: UUID,
        name: String,
        base64Data: String?,
        description: String,
        additionalInformation: String
    ) {
        self.id = id
        self.name = name
        
        if let dataString = base64Data {
            self.data = Data(base64Encoded: dataString)
        } else {
            self.data = nil
        }
        self.description = description
        self.additionalInformation = additionalInformation
    }
}
