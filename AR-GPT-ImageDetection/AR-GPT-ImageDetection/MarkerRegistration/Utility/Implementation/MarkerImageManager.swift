//
//  MarkerImageManager.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import CoreData

final class MarkerImageManager: MarkerImageManageable {
    var container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func fetchMarkerImage() -> [MarkerImage] {
        do {
            let markerImage = try self.container.viewContext.fetch(MarkerImageMO.fetchRequest())
            let result: [MarkerImage] = markerImage.compactMap { $0.toDomain() }
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
