//
//  Passport+CoreDataProperties.swift
//  CrudOperationCoreData
//
//  Created by Ryan on 2022/04/06.
//
//

import Foundation
import CoreData


extension Passport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passport> {
        return NSFetchRequest<Passport>(entityName: "Passport")
    }

    @NSManaged public var number: String?
    @NSManaged public var expiryDate: Date?
    @NSManaged public var ofUser: User?

}

extension Passport : Identifiable {

}
