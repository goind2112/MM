//
//  Tag+CoreDataProperties.swift
//  MM
//
//  Created by Даниил Мухсинятов on 31.12.2022.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String?
    @NSManaged public var isIncomeTag: Bool
    @NSManaged public var emoji: String?
    @NSManaged public var relationshipWithAuxiliaryEntitie: AuxiliaryEntitieTag?

}

extension Tag : Identifiable {

}
