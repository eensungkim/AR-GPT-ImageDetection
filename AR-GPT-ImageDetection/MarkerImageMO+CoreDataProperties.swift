//
//  MarkerImageMO+CoreDataProperties.swift
//  AR-GPT-ImageDetection
//
//  Created by Kim EenSung on 4/22/24.
//
//

import Foundation
import CoreData


extension MarkerImageMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarkerImageMO> {
        return NSFetchRequest<MarkerImageMO>(entityName: "MarkerImage")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var data: String
    @NSManaged public var information: String
    @NSManaged public var additionalInformation: String

}

extension MarkerImageMO : Identifiable {

}
