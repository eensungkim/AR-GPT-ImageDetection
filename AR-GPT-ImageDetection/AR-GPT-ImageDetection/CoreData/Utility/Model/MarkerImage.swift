//
//  MarkerImage.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/16/24.
//

import Foundation

/// 마커 이미지 구조체
struct MarkerImage {
    let id: UUID
    private(set) var name: String
    private(set) var data: Data
    private(set) var information: String
    private(set) var additionalInformation: String
    
    init(
        id: UUID,
        name: String,
        data: Data,
        information: String,
        additionalInformation: String
    ) {
        self.id = id
        self.name = name
        self.data = data
        self.information = information
        self.additionalInformation = additionalInformation
    }
    
    mutating func update(name: String, data: Data, information: String, additionalInformation: String) {
        self.name = name
        self.data = data
        self.information = information
        self.additionalInformation = additionalInformation
    }
}
