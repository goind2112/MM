//
//  Operation+CoreDataProperties.swift
//  MM
//
//  Created by Даниил Мухсинятов on 31.12.2022.
//
//

import Foundation
import CoreData


extension Operation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Operation> {
        return NSFetchRequest<Operation>(entityName: "Operation")
    }

    @NSManaged public var operationName: String?
    @NSManaged public var operationValue: Double
    @NSManaged public var dateOfOperation: Date?
    @NSManaged public var relationshipWithTag: Tag?

}

extension Operation : Identifiable {

}
