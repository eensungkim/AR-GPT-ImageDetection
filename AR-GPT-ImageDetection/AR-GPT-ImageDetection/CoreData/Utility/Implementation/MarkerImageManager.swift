//
//  MarkerImageManager.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import CoreData

final class MarkerImageManager {
    static let shared = MarkerImageManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarkerImageModel")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private init() { }
}

extension MarkerImageManager: MarkerImageManageable {
    func fetch() -> [MarkerImage] {
        do {
            let markerImage = try persistentContainer.viewContext.fetch(MarkerImageMO.fetchRequest())
            let result: [MarkerImage] = markerImage.compactMap { $0.toDomain() }
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func save() {
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    func delete(item: MarkerImageMO) {
        persistentContainer.viewContext.delete(item)
        save()
    }
}
