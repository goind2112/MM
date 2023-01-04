//
//  AuxiliaryEntitieTag+CoreDataProperties.swift
//  MM
//
//  Created by Даниил Мухсинятов on 31.12.2022.
//
//

import Foundation
import CoreData


extension AuxiliaryEntitieTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AuxiliaryEntitieTag> {
        return NSFetchRequest<AuxiliaryEntitieTag>(entityName: "AuxiliaryEntitieTag")
    }

    @NSManaged public var tagValue: Double
    @NSManaged public var tagId: Int16

}

extension AuxiliaryEntitieTag : Identifiable {

}
