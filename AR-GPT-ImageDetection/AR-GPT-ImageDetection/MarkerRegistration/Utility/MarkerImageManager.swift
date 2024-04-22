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
                      let name = marker.name,
                      let type = marker.type,
                      let data = marker.data,
                      let description = marker.information,
                      let additionalInformation = marker.additionalInformation else {
                    return nil
                }
                return MarkerImage(
                    id: id,
                    name: name,
                    type: type,
                    data: data,
                    description: description,
                    additionalInformation: additionalInformation
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
        markerImage.setValue(marker.type.rawValue, forKey: "type")
        
        do {
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
