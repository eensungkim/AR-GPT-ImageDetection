//
//  MarkerImageManager.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//

import CoreData

final class MarkerImageManager {
    private var container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func fetchMarkerImage() -> [MarkerImage] {
        do {
            let markerImage = try self.container.viewContext.fetch(MarkerImageMO.fetchRequest()) as! [MarkerImageMO]
            let result: [MarkerImage] = markerImage.compactMap { marker in
                guard let id = marker.id,
                      let name = marker.name else {
                    return nil
                }
                return MarkerImage(
                    id: id,
                    name: name,
                    base64Data: marker.data ?? "Unknown",
                    description: marker.information ?? "",
                    additionalInformation: marker.additionalInformation ?? ""
                )
            }
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveMarkerImage(_ marker: MarkerImage) {
        guard let entity = NSEntityDescription.entity(forEntityName: "MarkerImage", in: self.container.viewContext) else {
            return
        }
        
        let markerImage = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        markerImage.setValue(marker.name, forKey: "name")
        markerImage.setValue(marker.description, forKey: "information")
        markerImage.setValue(marker.additionalInformation, forKey: "additionalInformation")
        markerImage.setValue(marker.data, forKey: "data")
        markerImage.setValue(marker.id, forKey: "id")
        
        do {
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
