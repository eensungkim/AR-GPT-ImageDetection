//
//  MarkerImageMO+Mapping.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/23/24.
//

import CoreData

// MARK: - MarkerImage -> MarkerImageMO 변환
extension MarkerImageMO {
    convenience init(markerImage: MarkerImage, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = markerImage.id
        self.name = markerImage.name
        self.information = markerImage.description
        self.additionalInformation = markerImage.additionalInformation
        self.data = markerImage.data.base64EncodedString()
    }
}

// MARK: - MarkerImageMO -> MarkerImage 변환
extension MarkerImageMO {
    func toDomain() -> MarkerImage? {
        guard let encodedData = Data(base64Encoded: data) else { return nil }
        
        return .init(id: id, name: name, data: encodedData, description: information, additionalInformation: additionalInformation)
    }
}
