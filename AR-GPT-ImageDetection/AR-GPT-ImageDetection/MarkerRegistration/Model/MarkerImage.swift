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
    let data: Data
    let description: String
    let additionalInformation: String
    
    init(
        id: UUID,
        name: String,
        data: Data,
        description: String,
        additionalInformation: String
    ) {
        self.id = id
        self.name = name
        self.data = data
        self.description = description
        self.additionalInformation = additionalInformation
    }
}
